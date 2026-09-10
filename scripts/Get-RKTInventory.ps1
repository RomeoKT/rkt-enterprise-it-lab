param(
    [string]$OutputPath = "C:\RKTLogs\inventory.csv",
    [string]$LogPath = "C:\RKTLogs\inventory.log"
)

$ErrorActionPreference = "Stop"

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

    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

try {

    Write-Log "INFO" "Inventory collection started."

    # Computer information
    $ComputerSystem = Get-CimInstance `
        -ClassName Win32_ComputerSystem `
        -ErrorAction Stop

    # Operating system
    $OperatingSystem = Get-CimInstance `
        -ClassName Win32_OperatingSystem `
        -ErrorAction Stop

    # C: drive
    $Disk = Get-CimInstance `
        -ClassName Win32_LogicalDisk `
        -Filter "DeviceID='C:'" `
        -ErrorAction Stop

    # IPv4 addresses
    $IPv4 = Get-NetIPAddress `
        -AddressFamily IPv4 `
        -ErrorAction Stop |
        Where-Object {
            $_.IPAddress -ne "127.0.0.1" -and
            $_.IPAddress -notlike "169.254.*"
        } |
        Select-Object -ExpandProperty IPAddress

    # Create inventory object
    $Inventory = [PSCustomObject]@{
        Hostname       = $env:COMPUTERNAME
        OperatingSystem = $OperatingSystem.Caption
        OSVersion      = $OperatingSystem.Version
        RAM_GB         = [math]::Round(
            $ComputerSystem.TotalPhysicalMemory / 1GB,
            2
        )
        IPv4Address    = ($IPv4 -join "; ")
        Disk_C_Size_GB = [math]::Round(
            $Disk.Size / 1GB,
            2
        )
        Disk_C_Free_GB = [math]::Round(
            $Disk.FreeSpace / 1GB,
            2
        )
        LoggedUser     = $ComputerSystem.UserName
        CollectionTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }

    # Display result
    $Inventory | Format-List

    # Export result
    $Inventory |
        Export-Csv `
            -Path $OutputPath `
            -NoTypeInformation `
            -Encoding UTF8

    Write-Log "SUCCESS" "Inventory exported to $OutputPath."
}
catch {
    Write-Log "ERROR" "Inventory collection failed: $($_.Exception.Message)"
}