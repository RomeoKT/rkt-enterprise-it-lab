param(
    [string]$Gateway = "10.10.10.1",
    [string]$DnsServer = "10.10.20.10",
    [string]$DnsTestName = "DC01.corp.rktlab.test",
    [string]$DomainController = "10.10.20.10",
    [string]$FileServer = "10.10.20.20",
    [string]$InternetTarget = "1.1.1.1",
    [string]$OutputPath = "C:\RKTLogs\network-test.csv",
    [string]$LogPath = "C:\RKTLogs\network-test.log"
)

$ErrorActionPreference="Stop"
$Results=@()

$OutputDirectory=Split-Path $OutputPath -Parent
$LogDirectory=Split-Path $LogPath -Parent
foreach ($Directory in @($OutputDirectory,$LogDirectory) | Select-Object -Unique) {
    if (-not (Test-Path $Directory)) { New-Item -ItemType Directory -Path $Directory -Force | Out-Null }
}

function Write-Log {
    param([string]$Level,[string]$Message)
    $Timestamp=Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogPath -Value "[$Timestamp] [$Level] $Message"
}

function Add-TestResult {
    param([string]$Test,[string]$Target,[bool]$Passed,[string]$Details)
    $Status=if ($Passed) { "PASS" } else { "FAIL" }
    $script:Results += [PSCustomObject]@{Test=$Test;Target=$Target;Status=$Status;Details=$Details}
    Write-Log $Status "$Test - $Target - $Details"
}

Write-Log "INFO" "Début de la validation réseau."

try { Add-TestResult "Passerelle" $Gateway (Test-Connection -ComputerName $Gateway -Count 2 -Quiet -ErrorAction SilentlyContinue) "Connectivité ICMP" }
catch { Add-TestResult "Passerelle" $Gateway $false $_.Exception.Message }

try {
    Resolve-DnsName $DnsTestName -Server $DnsServer -ErrorAction Stop | Out-Null
    Add-TestResult "Résolution DNS" $DnsServer $true "$DnsTestName résolu"
}
catch { Add-TestResult "Résolution DNS" $DnsServer $false $_.Exception.Message }

try { Add-TestResult "Contrôleur de domaine" $DomainController (Test-Connection -ComputerName $DomainController -Count 2 -Quiet -ErrorAction SilentlyContinue) "Connectivité ICMP" }
catch { Add-TestResult "Contrôleur de domaine" $DomainController $false $_.Exception.Message }

try { Add-TestResult "Serveur de fichiers" $FileServer (Test-Connection -ComputerName $FileServer -Count 2 -Quiet -ErrorAction SilentlyContinue) "Connectivité ICMP" }
catch { Add-TestResult "Serveur de fichiers" $FileServer $false $_.Exception.Message }

try { Add-TestResult "Internet" "${InternetTarget}:443" (Test-NetConnection -ComputerName $InternetTarget -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue) "Connectivité TCP 443" }
catch { Add-TestResult "Internet" "${InternetTarget}:443" $false $_.Exception.Message }

try { Add-TestResult "Port DNS" "${DnsServer}:53" (Test-NetConnection -ComputerName $DnsServer -Port 53 -InformationLevel Quiet -WarningAction SilentlyContinue) "TCP 53" }
catch { Add-TestResult "Port DNS" "${DnsServer}:53" $false $_.Exception.Message }

try { Add-TestResult "Port SMB" "${FileServer}:445" (Test-NetConnection -ComputerName $FileServer -Port 445 -InformationLevel Quiet -WarningAction SilentlyContinue) "TCP 445" }
catch { Add-TestResult "Port SMB" "${FileServer}:445" $false $_.Exception.Message }

$Results | Format-Table -AutoSize
$Results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
Write-Log "INFO" "Validation réseau terminée."
Write-Host "Résultats exportés vers $OutputPath"

if ($Results.Status -contains "FAIL") { exit 1 }
