param(
    [Parameter(Mandatory = $true)]
    [string]$Identity,

    [string]$LogPath = "C:\RKTLogs\offboarding.log"
)

$ErrorActionPreference = "Stop"

Import-Module ActiveDirectory

$DisabledOU = "OU=Disabled-Accounts,DC=corp,DC=rktlab,DC=test"

# Create log directory
$LogDirectory = Split-Path $LogPath -Parent

if (-not (Test-Path $LogDirectory)) {
    New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null
}

function Write-Log {
    param(
        [string]$Level,
        [string]$Message
    )

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry = "[$Timestamp] [$Level] $Message"

    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

Write-Log "INFO" "Offboarding started for $Identity."

try {

    # Find user
    $User = Get-ADUser `
        -Identity $Identity `
        -Properties Enabled,DistinguishedName `
        -ErrorAction Stop

    # Verify Disabled-Accounts OU
    Get-ADOrganizationalUnit `
        -Identity $DisabledOU `
        -ErrorAction Stop | Out-Null

    # Get departmental groups before removing access
    $DepartmentGroups = Get-ADPrincipalGroupMembership `
        -Identity $User `
        -ErrorAction Stop |
        Where-Object {
            $_.Name -match "^GG_(FINANCE|HR|IT|SALES|OPERATIONS)_USERS$"
        }

    # Disable account
    Disable-ADAccount `
        -Identity $User `
        -ErrorAction Stop

    Write-Log "SUCCESS" "Disabled account $($User.SamAccountName)."

    # Remove departmental access
    foreach ($Group in $DepartmentGroups) {

        try {
            Remove-ADGroupMember `
                -Identity $Group `
                -Members $User `
                -Confirm:$false `
                -ErrorAction Stop

            Write-Log "SUCCESS" "Removed $($User.SamAccountName) from $($Group.Name)."
        }
        catch {
            Write-Log "ERROR" "Unable to remove $($User.SamAccountName) from $($Group.Name): $($_.Exception.Message)"
        }
    }

    # Move to Disabled-Accounts if not already there
    $User = Get-ADUser `
        -Identity $Identity `
        -Properties DistinguishedName `
        -ErrorAction Stop

    if ($User.DistinguishedName -notlike "*,$DisabledOU") {

        Move-ADObject `
            -Identity $User.DistinguishedName `
            -TargetPath $DisabledOU `
            -ErrorAction Stop

        Write-Log "SUCCESS" "Moved $($User.SamAccountName) to Disabled-Accounts."
    }
    else {
        Write-Log "INFO" "$($User.SamAccountName) is already in Disabled-Accounts."
    }

    Write-Log "INFO" "Offboarding completed for $($User.SamAccountName)."
}
catch {
    Write-Log "ERROR" "Offboarding failed for ${Identity}: $($_.Exception.Message)"
}