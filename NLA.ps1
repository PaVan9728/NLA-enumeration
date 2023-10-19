# Define the target remote computer's hostname or IP address
$computerName = "<Remote_Computer_Name>"

# Define the registry key path for NLA
$regKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
$regValueName = "UserAuthentication"

# Use Invoke-Command to run a script block on the remote computer
$result = Invoke-Command -ComputerName $computerName -ScriptBlock {
    param($path, $name)
    (Get-ItemProperty -Path $path).$name
} -ArgumentList $regKeyPath, $regValueName

# Check the result and display the status
if ($result -eq 1) {
    Write-Host "Network Level Authentication (NLA) is enabled on $computerName."
} elseif ($result -eq 0) {
    Write-Host "Network Level Authentication (NLA) is disabled on $computerName."
} else {
    Write-Host "Unable to determine NLA status on $computerName."
}
