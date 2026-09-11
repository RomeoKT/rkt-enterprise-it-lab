param(
    [string]$OutputPath = "C:\RKTLogs\inventory.csv"
)

$Directory = Split-Path $OutputPath -Parent
if (-not (Test-Path $Directory)) {
    New-Item -ItemType Directory -Path $Directory -Force | Out-Null
}

try {
    $Computer = Get-CimInstance Win32_ComputerSystem
    $OS = Get-CimInstance Win32_OperatingSystem
    $Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
    $IPv4 = Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
        $_.IPAddress -ne "127.0.0.1" -and $_.IPAddress -notlike "169.254.*"
    } | Select-Object -ExpandProperty IPAddress

    $Inventory = [PSCustomObject]@{
        Hostname = $env:COMPUTERNAME
        OS = $OS.Caption
        Version = $OS.Version
        RAM_GB = [math]::Round($Computer.TotalPhysicalMemory / 1GB, 2)
        IPv4 = ($IPv4 -join "; ")
        Disk_GB = [math]::Round($Disk.Size / 1GB, 2)
        Free_GB = [math]::Round($Disk.FreeSpace / 1GB, 2)
        User = $Computer.UserName
    }

    $Inventory | Format-List
    $Inventory | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "Export: $OutputPath"
}
catch {
    Write-Error $_.Exception.Message
}
