param(
    [string]$CsvPath,
    [string]$LogPath = "C:\RKTLogs\onboarding.log"
)

$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory

if ([string]::IsNullOrWhiteSpace($CsvPath)) {
    $ProjectRoot = Split-Path $PSScriptRoot -Parent
    $CsvPath = Join-Path $ProjectRoot "configs\users.csv"
}

$LogDirectory = Split-Path $LogPath -Parent
if (-not (Test-Path $LogDirectory)) {
    New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null
}

function Write-Log {
    param([string]$Level,[string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry = "[$Timestamp] [$Level] $Message"
    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

Write-Log "INFO" "Début de la création des utilisateurs."

if (-not (Test-Path $CsvPath)) {
    Write-Log "ERROR" "Fichier CSV introuvable : $CsvPath"
    exit 1
}

try { $Users = @(Import-Csv -Path $CsvPath -ErrorAction Stop) }
catch {
    Write-Log "ERROR" "Impossible de lire le fichier CSV : $($_.Exception.Message)"
    exit 1
}

if ($Users.Count -eq 0) {
    Write-Log "ERROR" "Le fichier CSV ne contient aucun utilisateur."
    exit 1
}

$RequiredColumns = @("FirstName","LastName","Department","Location","Title")
$Columns = $Users[0].PSObject.Properties.Name
foreach ($Column in $RequiredColumns) {
    if ($Column -notin $Columns) {
        Write-Log "ERROR" "Colonne CSV manquante : $Column"
        exit 1
    }
}

$TemporaryPassword = Read-Host "Mot de passe temporaire pour les nouveaux utilisateurs" -AsSecureString

foreach ($User in $Users) {
    try {
        if ([string]::IsNullOrWhiteSpace($User.FirstName) -or [string]::IsNullOrWhiteSpace($User.LastName) -or [string]::IsNullOrWhiteSpace($User.Department) -or [string]::IsNullOrWhiteSpace($User.Location) -or [string]::IsNullOrWhiteSpace($User.Title)) {
            throw "Un ou plusieurs champs obligatoires sont vides."
        }

        $FirstName=$User.FirstName.Trim(); $LastName=$User.LastName.Trim(); $Department=$User.Department.Trim(); $Location=$User.Location.Trim(); $Title=$User.Title.Trim()
        $SamAccountName="$($FirstName.ToLower()).$($LastName.ToLower())"
        $DisplayName="$FirstName $LastName"
        $UPN="$SamAccountName@corp.rktlab.test"
        $OUPath="OU=$Department,OU=Departments,DC=corp,DC=rktlab,DC=test"

        if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue) {
            Write-Log "SKIPPED" "$SamAccountName existe déjà."
            continue
        }

        Get-ADOrganizationalUnit -Identity $OUPath -ErrorAction Stop | Out-Null
        $GlobalGroup="GG_$($Department.ToUpper())_USERS"
        Get-ADGroup -Identity $GlobalGroup -ErrorAction Stop | Out-Null

        New-ADUser -Name $DisplayName -GivenName $FirstName -Surname $LastName -DisplayName $DisplayName -SamAccountName $SamAccountName -UserPrincipalName $UPN -Department $Department -Title $Title -Office $Location -Path $OUPath -AccountPassword $TemporaryPassword -Enabled $true -ChangePasswordAtLogon $true -ErrorAction Stop
        Write-Log "SUCCESS" "Utilisateur $SamAccountName créé dans $OUPath."

        Add-ADGroupMember -Identity $GlobalGroup -Members $SamAccountName -ErrorAction Stop
        Write-Log "SUCCESS" "$SamAccountName ajouté à $GlobalGroup."
    }
    catch {
        Write-Log "ERROR" "$($User.FirstName) $($User.LastName) : $($_.Exception.Message)"
        continue
    }
}

Write-Log "INFO" "Traitement terminé."
