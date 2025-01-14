# Define the URL for Sophos Connect 2.3.2
$sophosUrl = "https://download.sophos.com/network/clients/SophosConnect_2.3.2_IPsec_and_SSLVPN.msi"

# Define the destination path
$destinationPath = "C:\Temp\SophosConnect.msi"

# Create the destination directory if it doesn't exist
if (!(Test-Path -Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp" -Force
}

# Download the file using BITS transfer
Start-BitsTransfer -Source $sophosUrl -Destination $destinationPath

Write-Host "Sophos Connect 2.3.2 has been downloaded to $destinationPath"

taskkill /f /im msiexec.exe
msiexec /i "C:\Temp\SophosConnect.msi" /quiet /norestart ALLUSERS=1 /log "C:\temp\SC_Log_.txt"
