param(
    [string]$CsvPath,
    [string]$LogPath = "C:\RKTLogs\onboarding.log"
)

$ErrorActionPreference = "Stop"

Import-Module ActiveDirectory

# Use the configs folder located next to the scripts folder
if ([string]::IsNullOrWhiteSpace($CsvPath)) {
    $ProjectRoot = Split-Path $PSScriptRoot -Parent
    $CsvPath = Join-Path $ProjectRoot "configs\users.csv"
}

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

Write-Log "INFO" "Onboarding started."

# Verify CSV
if (-not (Test-Path $CsvPath)) {
    Write-Log "ERROR" "CSV file not found: $CsvPath"
    exit 1
}

try {
    $Users = @(Import-Csv -Path $CsvPath -ErrorAction Stop)
}
catch {
    Write-Log "ERROR" "Unable to read CSV: $($_.Exception.Message)"
    exit 1
}

if ($Users.Count -eq 0) {
    Write-Log "ERROR" "CSV file contains no users."
    exit 1
}

# Verify required columns
$RequiredColumns = @(
    "FirstName",
    "LastName",
    "Department",
    "Location",
    "Title"
)

$Columns = $Users[0].PSObject.Properties.Name

foreach ($Column in $RequiredColumns) {
    if ($Column -notin $Columns) {
        Write-Log "ERROR" "Missing CSV column: $Column"
        exit 1
    }
}

# Ask for password securely
$TemporaryPassword = Read-Host "Enter temporary password for new users" -AsSecureString

foreach ($User in $Users) {

    try {
        # Validate fields
        if (
            [string]::IsNullOrWhiteSpace($User.FirstName) -or
            [string]::IsNullOrWhiteSpace($User.LastName) -or
            [string]::IsNullOrWhiteSpace($User.Department) -or
            [string]::IsNullOrWhiteSpace($User.Location) -or
            [string]::IsNullOrWhiteSpace($User.Title)
        ) {
            throw "One or more required CSV fields are empty."
        }

        $FirstName  = $User.FirstName.Trim()
        $LastName   = $User.LastName.Trim()
        $Department = $User.Department.Trim()
        $Location   = $User.Location.Trim()
        $Title      = $User.Title.Trim()

        # Generate username
        $SamAccountName = "$($FirstName.ToLower()).$($LastName.ToLower())"

        $DisplayName = "$FirstName $LastName"
        $UPN = "$SamAccountName@corp.rktlab.test"

        # Department OU
        $OUPath = "OU=$Department,OU=Departments,DC=corp,DC=rktlab,DC=test"

        # Verify if user already exists
        $ExistingUser = Get-ADUser `
            -Filter "SamAccountName -eq '$SamAccountName'" `
            -ErrorAction SilentlyContinue

        if ($ExistingUser) {
            Write-Log "SKIPPED" "$SamAccountName already exists."
            continue
        }

        # Verify OU exists
        Get-ADOrganizationalUnit `
            -Identity $OUPath `
            -ErrorAction Stop | Out-Null

        # Determine departmental Global Group
        $GlobalGroup = "GG_$($Department.ToUpper())_USERS"

        # Verify group exists
        Get-ADGroup `
            -Identity $GlobalGroup `
            -ErrorAction Stop | Out-Null

        # Create AD user
        New-ADUser `
            -Name $DisplayName `
            -GivenName $FirstName `
            -Surname $LastName `
            -DisplayName $DisplayName `
            -SamAccountName $SamAccountName `
            -UserPrincipalName $UPN `
            -Department $Department `
            -Title $Title `
            -Office $Location `
            -Path $OUPath `
            -AccountPassword $TemporaryPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -ErrorAction Stop

        Write-Log "SUCCESS" "Created user $SamAccountName in $OUPath."

        # Add user to departmental Global Group
        Add-ADGroupMember `
            -Identity $GlobalGroup `
            -Members $SamAccountName `
            -ErrorAction Stop

        Write-Log "SUCCESS" "Added $SamAccountName to $GlobalGroup."
    }
    catch {
        Write-Log "ERROR" "$($User.FirstName) $($User.LastName): $($_.Exception.Message)"
        continue
    }
}

Write-Log "INFO" "Onboarding completed."