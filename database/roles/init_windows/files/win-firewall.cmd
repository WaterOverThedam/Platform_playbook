netsh advfirewall firewall show rule name="RDP"||netsh advfirewall firewall add rule name="RDP" dir=in protocol=tcp localport=%1 action=allow
netsh advfirewall firewall show rule name="SQLSERVER_WIN60"||netsh advfirewall firewall add rule name="SQLSERVER_WIN60" dir=in protocol=tcp localport=%2 action=allow
netsh advfirewall firewall show rule name="WinRM"||netsh advfirewall firewall add rule name="WinRM" dir=in protocol=tcp localport=5985,5986 action=allow
netsh advfirewall set allprofiles state on