$ErrorActionPreference = "SilentlyContinue"
Set-ExecutionPolicy bypass -Force

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

$ScriptVersion = "1.0"

# Set the location to the registry
Set-Location -Path 'HKLM:\Software'

# Create a new Key
Get-Item -Path 'HKLM:\Software' | New-Item -Name 'ScriptDetection' -Force

# Create new items with values
New-ItemProperty -Path 'HKLM:\Software\ScriptDetection' -Name 'RemoveBuiltinWindowsApps' -Value "$ScriptVersion" -PropertyType String -Force
 
#wget "https://s3.amazonaws.com/download.dymo.com/dymo/Software/Win/DCDSetup1.4.3.131.exe" -outfile C:\ProgramData\RemoveWindowsBuiltInApps\DCDSetup1.4.3.131.exe
