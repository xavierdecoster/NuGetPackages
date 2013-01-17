param($installPath, $toolsPath, $package, $project)

# Configure
$moduleName = "VS2012.RemoveAllCaps"

# Derived variables
$psdFileName = "$moduleName.psd1"
$psmFileName = "$moduleName.psm1"
$psd = (Join-Path $toolsPath $psdFileName)
$psm = (Join-Path $toolsPath $psmFileName)

# Check if the NuGet_profile.ps1 exists and register the module
if(!(Test-Path $profile)){
mkdir -force (Split-Path $profile)
New-Item $profile -Type file -Value "Import-Module $moduleName -DisableNameChecking"
}
else{
Add-Content -Path $profile -Value "`r`nImport-Module $moduleName -DisableNameChecking"
}

# Copy the files to the module in the profile directory
$profileDirectory = Split-Path $profile -parent
$profileModulesDirectory = (Join-Path $profileDirectory "Modules")
$moduleDir = (Join-Path $profileModulesDirectory $moduleName)
if(!(Test-Path $moduleDir)){
mkdir -force $moduleDir
}
copy $psd (Join-Path $moduleDir $psdFileName)
copy $psm (Join-Path $moduleDir $psmFileName)

# Reload NuGet PowerShell profile
. $profile

Write-Host ""
Write-Host "*************************************************************************************"
Write-Host " $moduleName INSTRUCTIONS"
Write-Host "*************************************************************************************"
Write-Host " - YOU NO LIKE NO SHOUTING?! Run Disable-AllCaps"
Write-Host " - Else: Enable-AllCaps"
Write-Host "*************************************************************************************"
Write-Host ""