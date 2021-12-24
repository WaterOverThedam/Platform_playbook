@echo off
set srv=%1
echo %srv%
echo --------------------------------

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Parameters /v NtpServer /t REG_SZ /d %srv%,0x1 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\TimeProviders\NtpClient /v Enabled /t REG_DWORD /d 0x00000001 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\TimeProviders\NtpClient /v SpecialPollInterval /t REG_DWORD /d 0x12c /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers /v 1 /t REG_SZ /d %srv% /f
w32tm /config /manualpeerlist:"%srv%" /syncfromflags:manual /reliable:yes /update

echo --------------------------------
w32tm /register
net stop w32time
net start w32time
SC CONFIG w32time START= auto

w32tm /resync
w32tm /query /peers
w32tm /query /source
