param(
    [Parameter(Mandatory = $true)]
    [string]$Identity
)

Import-Module ActiveDirectory

$DisabledOU = "OU=Disabled-Accounts,DC=corp,DC=rktlab,DC=test"

try {
    $User = Get-ADUser -Identity $Identity -Properties DistinguishedName -ErrorAction Stop
    $Groups = Get-ADPrincipalGroupMembership -Identity $User | Where-Object Name -match '^GG_(FINANCE|HR|IT|SALES|OPERATIONS)_USERS$'

    Disable-ADAccount -Identity $User

    foreach ($Group in $Groups) {
        Remove-ADGroupMember -Identity $Group -Members $User -Confirm:$false
    }

    $User = Get-ADUser -Identity $Identity -Properties DistinguishedName

    if ($User.DistinguishedName -notlike "*,$DisabledOU") {
        Move-ADObject -Identity $User.DistinguishedName -TargetPath $DisabledOU
    }

    Write-Host "Compte desactive: $($User.SamAccountName)"
}
catch {
    Write-Error $_.Exception.Message
}
