# Define the URL for Sophos Connect 2.3.2
$sophosUrl = "https://download.sophos.com/network/clients/SophosConnect_2.3.2_IPsec_and_SSLVPN.msi"

# Define the destination path
$destinationPath = "C:\Temp\SophosConnect.msi"

# Create the destination directory if it doesn't exist
if (!(Test-Path -Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp" -Force
}

# Check if the file exists and delete it if it does
if (Test-Path -Path $destinationPath) {
    Remove-Item -Path $destinationPath -Force
}

# Download the file using BITS transfer
Start-BitsTransfer -Source $sophosUrl -Destination $destinationPath

Write-Host "Sophos Connect 2.3.2 has been downloaded to $destinationPath"

# Kill any running instances of msiexec.exe
Stop-Process -Name "msiexec" -Force

# Install the MSI file silently
Start-Process msiexec.exe -ArgumentList "/i `"$destinationPath`" /quiet /norestart ALLUSERS=1 /log `"$env:TEMP\SC_Log_.txt`"" -NoNewWindow -Wait

Write-Host "Sophos Connect 2.3.2 installation completed."
