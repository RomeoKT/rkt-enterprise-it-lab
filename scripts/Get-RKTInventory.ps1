param(
    [string]$OutputPath = "C:\RKTLogs\inventory.csv",
    [string]$LogPath = "C:\RKTLogs\inventory.log"
)

$ErrorActionPreference = "Stop"
$OutputDirectory=Split-Path $OutputPath -Parent
$LogDirectory=Split-Path $LogPath -Parent
foreach ($Directory in @($OutputDirectory,$LogDirectory) | Select-Object -Unique) {
    if (-not (Test-Path $Directory)) { New-Item -ItemType Directory -Path $Directory -Force | Out-Null }
}

function Write-Log {
    param([string]$Level,[string]$Message)
    $Timestamp=Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry="[$Timestamp] [$Level] $Message"
    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

try {
    Write-Log "INFO" "Début de la collecte d'inventaire."
    $ComputerSystem=Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
    $OperatingSystem=Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
    $Disk=Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'" -ErrorAction Stop
    $IPv4=Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | Where-Object { $_.IPAddress -ne "127.0.0.1" -and $_.IPAddress -notlike "169.254.*" } | Select-Object -ExpandProperty IPAddress

    $Inventory=[PSCustomObject]@{
        Hostname=$env:COMPUTERNAME
        OperatingSystem=$OperatingSystem.Caption
        OSVersion=$OperatingSystem.Version
        RAM_GB=[math]::Round($ComputerSystem.TotalPhysicalMemory/1GB,2)
        IPv4Address=($IPv4 -join "; ")
        Disk_C_Size_GB=[math]::Round($Disk.Size/1GB,2)
        Disk_C_Free_GB=[math]::Round($Disk.FreeSpace/1GB,2)
        LoggedUser=$ComputerSystem.UserName
        CollectionTime=Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }

    $Inventory | Format-List
    $Inventory | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Log "SUCCESS" "Inventaire exporté vers $OutputPath."
}
catch {
    Write-Log "ERROR" "Échec de la collecte d'inventaire : $($_.Exception.Message)"
    exit 1
}
