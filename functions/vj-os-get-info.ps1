function vj-os-Get-Info
{
	param($ComputerName = '.')
	Get-WmiObject -ComputerName $ComputerName -Class Win32_BIOS
}