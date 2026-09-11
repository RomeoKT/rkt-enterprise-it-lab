param(
    [string]$CsvPath
)

Import-Module ActiveDirectory

if (-not $CsvPath) {
    $CsvPath = Join-Path (Split-Path $PSScriptRoot -Parent) "configs\users.csv"
}

if (-not (Test-Path $CsvPath)) {
    Write-Error "CSV introuvable: $CsvPath"
    exit 1
}

$Users = Import-Csv $CsvPath
if (-not $Users) {
    Write-Error "CSV vide"
    exit 1
}

$Password = Read-Host "Mot de passe temporaire" -AsSecureString

foreach ($User in $Users) {
    $FirstName = $User.FirstName.Trim()
    $LastName = $User.LastName.Trim()
    $Department = $User.Department.Trim()
    $Location = $User.Location.Trim()
    $Title = $User.Title.Trim()
    $Sam = "$($FirstName.ToLower()).$($LastName.ToLower())"
    $OU = "OU=$Department,OU=Departments,DC=corp,DC=rktlab,DC=test"
    $Group = "GG_$($Department.ToUpper())_USERS"

    try {
        if (Get-ADUser -Filter "SamAccountName -eq '$Sam'" -ErrorAction SilentlyContinue) {
            Write-Host "$Sam existe deja"
            continue
        }

        New-ADUser -Name "$FirstName $LastName" -GivenName $FirstName -Surname $LastName -DisplayName "$FirstName $LastName" -SamAccountName $Sam -UserPrincipalName "$Sam@corp.rktlab.test" -Department $Department -Title $Title -Office $Location -Path $OU -AccountPassword $Password -Enabled $true -ChangePasswordAtLogon $true -ErrorAction Stop
        Add-ADGroupMember -Identity $Group -Members $Sam -ErrorAction Stop
        Write-Host "Cree: $Sam"
    }
    catch {
        Write-Error "$Sam : $($_.Exception.Message)"
    }
}
