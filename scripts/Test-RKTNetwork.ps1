param(
    [string]$Gateway = "10.10.10.1",
    [string]$DnsServer = "10.10.20.10",
    [string]$DomainController = "10.10.20.10",
    [string]$FileServer = "10.10.20.20",
    [string]$InternetTarget = "1.1.1.1",
    [string]$OutputPath = "C:\RKTLogs\network-test.csv",
    [string]$LogPath = "C:\RKTLogs\network-test.log"
)

$ErrorActionPreference = "Stop"

$Results = @()

$OutputDirectory = Split-Path $OutputPath -Parent

if (-not (Test-Path $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
}

function Write-Log {
    param(
        [string]$Level,
        [string]$Message
    )

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry = "[$Timestamp] [$Level] $Message"

    Add-Content -Path $LogPath -Value $Entry
}

function Add-TestResult {
    param(
        [string]$Test,
        [string]$Target,
        [bool]$Passed,
        [string]$Details
    )

    $Status = if ($Passed) {
        "PASS"
    }
    else {
        "FAIL"
    }

    $script:Results += [PSCustomObject]@{
        Test    = $Test
        Target  = $Target
        Status  = $Status
        Details = $Details
    }

    Write-Log $Status "$Test - $Target - $Details"
}

Write-Log "INFO" "Network validation started."

# ------------------------------------------------
# TEST 1 - Gateway
# ------------------------------------------------

try {

    $Passed = Test-Connection `
        -ComputerName $Gateway `
        -Count 2 `
        -Quiet `
        -ErrorAction SilentlyContinue

    Add-TestResult `
        "Gateway" `
        $Gateway `
        $Passed `
        "ICMP connectivity"
}
catch {

    Add-TestResult `
        "Gateway" `
        $Gateway `
        $false `
        $_.Exception.Message
}

# ------------------------------------------------
# TEST 2 - DNS
# ------------------------------------------------

try {

    Resolve-DnsName `
        "corp.rktlab.test" `
        -Server $DnsServer `
        -ErrorAction Stop | Out-Null

    Add-TestResult `
        "DNS Resolution" `
        $DnsServer `
        $true `
        "corp.rktlab.test resolved successfully"
}
catch {

    Add-TestResult `
        "DNS Resolution" `
        $DnsServer `
        $false `
        $_.Exception.Message
}

# ------------------------------------------------
# TEST 3 - Domain Controller
# ------------------------------------------------

try {

    $Passed = Test-Connection `
        -ComputerName $DomainController `
        -Count 2 `
        -Quiet `
        -ErrorAction SilentlyContinue

    Add-TestResult `
        "Domain Controller" `
        $DomainController `
        $Passed `
        "ICMP connectivity"
}
catch {

    Add-TestResult `
        "Domain Controller" `
        $DomainController `
        $false `
        $_.Exception.Message
}

# ------------------------------------------------
# TEST 4 - FS01
# ------------------------------------------------

try {

    $Passed = Test-Connection `
        -ComputerName $FileServer `
        -Count 2 `
        -Quiet `
        -ErrorAction SilentlyContinue

    Add-TestResult `
        "File Server" `
        $FileServer `
        $Passed `
        "ICMP connectivity"
}
catch {

    Add-TestResult `
        "File Server" `
        $FileServer `
        $false `
        $_.Exception.Message
}

# ------------------------------------------------
# TEST 5 - Internet
# ------------------------------------------------

try {

    $Passed = Test-NetConnection `
        -ComputerName $InternetTarget `
        -Port 443 `
        -InformationLevel Quiet `
        -WarningAction SilentlyContinue

    Add-TestResult `
        "Internet" `
        "${InternetTarget}:443" `
        $Passed `
        "TCP 443 connectivity"
}
catch {

    Add-TestResult `
        "Internet" `
        "${InternetTarget}:443" `
        $false `
        $_.Exception.Message
}

# ------------------------------------------------
# TEST 6 - DNS TCP 53
# ------------------------------------------------

try {

    $Passed = Test-NetConnection `
        -ComputerName $DnsServer `
        -Port 53 `
        -InformationLevel Quiet `
        -WarningAction SilentlyContinue

    Add-TestResult `
        "DNS Port" `
        "${DnsServer}:53" `
        $Passed `
        "TCP 53"
}
catch {

    Add-TestResult `
        "DNS Port" `
        "${DnsServer}:53" `
        $false `
        $_.Exception.Message
}

# ------------------------------------------------
# TEST 7 - SMB TCP 445
# ------------------------------------------------

try {

    $Passed = Test-NetConnection `
        -ComputerName $FileServer `
        -Port 445 `
        -InformationLevel Quiet `
        -WarningAction SilentlyContinue

    Add-TestResult `
        "SMB Port" `
        "${FileServer}:445" `
        $Passed `
        "TCP 445"
}
catch {

    Add-TestResult `
        "SMB Port" `
        "${FileServer}:445" `
        $false `
        $_.Exception.Message
}

# ------------------------------------------------
# RESULTS
# ------------------------------------------------

$Results | Format-Table -AutoSize

$Results |
    Export-Csv `
        -Path $OutputPath `
        -NoTypeInformation `
        -Encoding UTF8

Write-Log "INFO" "Network validation completed."
Write-Host ""
Write-Host "Results exported to $OutputPath"