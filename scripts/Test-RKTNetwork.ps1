param(
    [string]$Gateway = "10.10.10.1",
    [string]$DnsServer = "10.10.20.10",
    [string]$DomainController = "10.10.20.10",
    [string]$FileServer = "10.10.20.20",
    [string]$InternetTarget = "1.1.1.1",
    [string]$OutputPath = "C:\RKTLogs\network-test.csv"
)

$Directory = Split-Path $OutputPath -Parent
if (-not (Test-Path $Directory)) {
    New-Item -ItemType Directory -Path $Directory -Force | Out-Null
}

$Results = @()

function Add-Result {
    param($Test, $Target, $Passed)

    $script:Results += [PSCustomObject]@{
        Test = $Test
        Target = $Target
        Status = if ($Passed) { "OK" } else { "FAIL" }
    }
}

Add-Result "Gateway" $Gateway (Test-Connection $Gateway -Count 1 -Quiet -ErrorAction SilentlyContinue)
Add-Result "DC01" $DomainController (Test-Connection $DomainController -Count 1 -Quiet -ErrorAction SilentlyContinue)
Add-Result "FS01" $FileServer (Test-Connection $FileServer -Count 1 -Quiet -ErrorAction SilentlyContinue)

try {
    Resolve-DnsName "corp.rktlab.test" -Server $DnsServer -ErrorAction Stop | Out-Null
    Add-Result "DNS" $DnsServer $true
}
catch {
    Add-Result "DNS" $DnsServer $false
}

Add-Result "Internet 443" "$InternetTarget`:443" (Test-NetConnection $InternetTarget -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue)
Add-Result "DNS 53" "$DnsServer`:53" (Test-NetConnection $DnsServer -Port 53 -InformationLevel Quiet -WarningAction SilentlyContinue)
Add-Result "SMB 445" "$FileServer`:445" (Test-NetConnection $FileServer -Port 445 -InformationLevel Quiet -WarningAction SilentlyContinue)

$Results | Format-Table -AutoSize
$Results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
Write-Host "Export: $OutputPath"
