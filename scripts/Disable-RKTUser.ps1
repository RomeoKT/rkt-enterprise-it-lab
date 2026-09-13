param(
    [Parameter(Mandatory = $true)]
    [string]$Identity
)

$DisabledOU = "OU=Disabled-Accounts,DC=corp,DC=rktlab,DC=test"

try {
    Import-Module ActiveDirectory -ErrorAction Stop

    $User = Get-ADUser -Identity $Identity -Properties DistinguishedName -ErrorAction Stop
    $Groups = Get-ADPrincipalGroupMembership -Identity $User -ErrorAction Stop | Where-Object Name -match '^GG_(FINANCE|HR|IT|SALES|OPERATIONS)_USERS$'

    Disable-ADAccount -Identity $User -ErrorAction Stop

    foreach ($Group in $Groups) {
        Remove-ADGroupMember -Identity $Group -Members $User -Confirm:$false -ErrorAction Stop
    }

    $User = Get-ADUser -Identity $Identity -Properties DistinguishedName -ErrorAction Stop

    if ($User.DistinguishedName -notlike "*,$DisabledOU") {
        Move-ADObject -Identity $User.DistinguishedName -TargetPath $DisabledOU -ErrorAction Stop
    }

    Write-Host "Compte desactive: $($User.SamAccountName)"
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
