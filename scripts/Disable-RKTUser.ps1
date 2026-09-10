param(
    [Parameter(Mandatory = $true)]
    [string]$Identity,
    [string]$LogPath = "C:\RKTLogs\offboarding.log"
)

$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory
$DisabledOU = "OU=Disabled-Accounts,DC=corp,DC=rktlab,DC=test"

$LogDirectory = Split-Path $LogPath -Parent
if (-not (Test-Path $LogDirectory)) { New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null }

function Write-Log {
    param([string]$Level,[string]$Message)
    $Timestamp=Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry="[$Timestamp] [$Level] $Message"
    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

Write-Log "INFO" "Début de la désactivation de $Identity."

try {
    $User=Get-ADUser -Identity $Identity -Properties Enabled,DistinguishedName -ErrorAction Stop
    Get-ADOrganizationalUnit -Identity $DisabledOU -ErrorAction Stop | Out-Null

    $DepartmentGroups=Get-ADPrincipalGroupMembership -Identity $User -ErrorAction Stop | Where-Object { $_.Name -match "^GG_(FINANCE|HR|IT|SALES|OPERATIONS)_USERS$" }

    Disable-ADAccount -Identity $User -ErrorAction Stop
    Write-Log "SUCCESS" "Compte $($User.SamAccountName) désactivé."

    foreach ($Group in $DepartmentGroups) {
        try {
            Remove-ADGroupMember -Identity $Group -Members $User -Confirm:$false -ErrorAction Stop
            Write-Log "SUCCESS" "$($User.SamAccountName) retiré de $($Group.Name)."
        }
        catch { Write-Log "ERROR" "Impossible de retirer $($User.SamAccountName) de $($Group.Name) : $($_.Exception.Message)" }
    }

    $User=Get-ADUser -Identity $Identity -Properties DistinguishedName -ErrorAction Stop
    if ($User.DistinguishedName -notlike "*,$DisabledOU") {
        Move-ADObject -Identity $User.DistinguishedName -TargetPath $DisabledOU -ErrorAction Stop
        Write-Log "SUCCESS" "$($User.SamAccountName) déplacé vers Disabled-Accounts."
    }
    else { Write-Log "INFO" "$($User.SamAccountName) est déjà dans Disabled-Accounts." }

    Write-Log "INFO" "Désactivation terminée pour $($User.SamAccountName)."
}
catch {
    Write-Log "ERROR" "Échec de la désactivation de ${Identity} : $($_.Exception.Message)"
    exit 1
}
