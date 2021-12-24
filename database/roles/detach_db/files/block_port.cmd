netsh advfirewall firewall show rule name=all|findstr "SQLSERVER_WIN60" && netsh advfirewall firewall delete rule name="SQLSERVER_WIN60"
netsh advfirewall firewall add rule name="SQLSERVER_WIN60" dir=in protocol=tcp localport=%1 action=allow
