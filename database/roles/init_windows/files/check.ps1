# 获取硬盘空余空间
function get_disk_free(){
$disk = Get-WmiObject -Class win32_logicaldisk
$freedisk = $disk.FreeSpace 
$freedisk =(($freedisk | Measure-Object -Sum).sum /1gb)
return @($freedisk)
}
echo "{'get_disk_free':'$(get_disk_free)'}"
 
# 获取磁盘使用率
function get_disk_used_percent(){
$disk = Get-WmiObject -Class win32_logicaldisk
$allSpace = $disk.Size 
$allSpace =(($allSpace | Measure-Object -Sum).sum /1gb)
$FreeSpace = $disk.FreeSpace 
$FreeSpace =(($FreeSpace | Measure-Object -Sum).sum /1gb)
$disk_used_percent =  (($FreeSpace/$allSpace)*100)
return @($disk_used_percent)
}
echo "{'get_disk_used_percent':'$(get_disk_used_percent)'}"
 
function get_memory_count(){
"{0:N2}GB" -f (((Get-WmiObject -Class Win32_PhysicalMemory).capacity | Measure-Object -Sum).sum /1gb)}
echo "{'memory': '$(get_memory_count)'}"
 
#获取主机ip
function get_ip(){
$ip=((Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'").IPAddress -notlike ":")[0]
$ip
}
echo "system_ip:$(get_ip)"
 
#获取主机系统版本
function get_type(){
Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty Caption}
echo "system_version:$(get_type)"
 
 
# 获取 CPU 逻辑核心数
function get_logical_cpu_cnt () {
    $cpu_info = Get-WmiObject win32_processor
    return @($cpu_info).count * $cpu_info.NumberOfLogicalProcessors
}
echo "cpu number:$(get_logical_cpu_cnt)"
 
# 获取 可用内存
function free_physics_ram(){
$ops = Get-WmiObject -Class Win32_OperatingSystem
#"可用内存(MB): {0}" -f ([math]::round($ops.FreePhysicalMemory / 1kb, 2))
$ops =([math]::round(($ops.FreePhysicalMemory / (1mb)), 2))
return @($ops)
}
echo "free_physics_ram:$(free_physics_ram) GB"
 
# 获取CPU使用率
function cpu_percent()
{
$cpu = Get-WmiObject -Class Win32_Processor 
$Havecpu = $cpu.LoadPercentage 
return @($Havecpu)
}
echo "cpu_used_percent:$(cpu_percent)%"
 
# 获取内存使用率
function phy_percent()
{
$men = Get-WmiObject -Class win32_OperatingSystem
$Allmen = ($men.TotalVisibleMemorySize  / 1KB) 
$Freemen = ($men.FreePhysicalMemory  / 1KB) 
$Permem =  ((($men.TotalVisibleMemorySize-$men.FreePhysicalMemory)/$men.TotalVisibleMemorySize)*100)
return @($Permem)
}
echo "phy_used_percent:$(phy_percent)%"
 