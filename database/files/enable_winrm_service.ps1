netsh advfirewall firewall add rule name="WinRM" dir=in protocol=tcp localport=5985,5986 action=allow
set-executionpolicy remotesigned -f
winrm quickconfig -q
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm enumerate winrm/config/listener

winrm configSDDL default
Restart-Service WinRM