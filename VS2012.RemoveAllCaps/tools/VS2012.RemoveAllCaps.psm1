function Disable-AllCaps{
	Set-AllCaps 1
}

function Enable-AllCaps{
	Set-AllCaps 0
}

function Set-AllCaps ($value) {
	$root = $DTE.RegistryRoot
	$path = "HKCU:\$root\General"
	Set-ItemProperty -Path $path -Name SuppressUppercaseConversion -Type DWord -Value $value
	Write-Host "Please restart Visual Studio for changes to take effect."
}

