$ErrorActionPreference = "SilentlyContinue"
Set-ExecutionPolicy bypass -Force

$RegistryPath = "HKLM:\Software\ScriptDetection"
$RegistryValueName = "RemoveBuiltinWindowsApps"
$ScriptVersion = "1.0"

# Create or update the registry key and value
New-Item -Path $RegistryPath -Force | Out-Null
Set-ItemProperty -Path $RegistryPath -Name $RegistryValueName -Value $ScriptVersion

New-Item -Path "Registry::HKEY_LOCAL_MACHINE\Software\" -Name "ScriptDetection" -Force
New-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\Software\ScriptDetection" -Name "RemoveBuiltinWindowsApps" -Value "1.0" -PropertyType String

$RemoveApps = "*Microsoft.BingNews*",
"*Microsoft.PowerAutomateDesktop*",
"*MicrosoftTeams*",
"*Microsoft.GamingApp*",
"*Microsoft.BingWeather*",
"*Clipchamp.Clipchamp*",
"*Microsoft.GetHelp*",
"*Microsoft.Getstarted*",
"*Microsoft.Messaging*",
"*Microsoft.Microsoft3DViewer*",
"*Microsoft.MicrosoftOfficeHub*",
"*Microsoft.MicrosoftSolitaireCollection*",
"*Microsoft.MixedReality.Portal*",
"*Microsoft.OneConnect*",
"*Microsoft.People*",
"*Microsoft.Print3D*",
"*Microsoft.SkypeApp*",
"*MicrosoftTeams*",
"*Microsoft.Wallet*",
"*microsoft.windowscommunicationsapps*",
"*Microsoft.WindowsFeedbackHub*",
"*Microsoft.WindowsMaps*",
"*Microsoft.Xbox.TCUI*",
"*Microsoft.XboxApp*",
"*Microsoft.XboxGameOverlay*",
"*Microsoft.XboxGamingOverlay*",
"*Microsoft.XboxIdentityProvider*",
"*Microsoft.XboxSpeechToTextOverlay*",
"*Microsoft.XboxGameCallableUI*",
"*Microsoft.YourPhone*",
"*Microsoft.ZuneMusic*",
"*Microsoft.ZuneVideo*"


ForEach ($Name in $RemoveApps)
{
    Get-AppxPackage $Name | Remove-AppxPackage -AllUsers -ErrorAction Continue
}

ForEach ($Name in $RemoveApps)
{
    ForEach ($Package in (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like $Name}))
    {
        Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $Package.PackageName -ErrorAction Continue
    }
}
 
 #Test Script

#wget "https://s3.amazonaws.com/download.dymo.com/dymo/Software/Win/DCDSetup1.4.3.131.exe" -outfile C:\ProgramData\RemoveWindowsBuiltInApps\DCDSetup1.4.3.131.exe
