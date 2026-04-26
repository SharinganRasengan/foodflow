$workspace = Split-Path -Parent $MyInvocation.MyCommand.Path
$targetExe = Join-Path $workspace "FoodFlowDesktop.exe"
$sedPath = Join-Path $workspace "foodflow-package.sed"

# IExpress can wrap the app files into a self-extracting EXE without external tools.
$sedContent = @"
[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=
DisplayLicense=
FinishMessage=
TargetName=$targetExe
FriendlyName=FoodFlow Desktop
AppLaunched=start-foodflow.bat
PostInstallCmd=<None>
AdminQuietInstCmd=
UserQuietInstCmd=
SourceFiles=SourceFiles
[SourceFiles]
SourceFiles0=$workspace
[SourceFiles0]
%FILE0%= 
%FILE1%= 
[Strings]
FILE0=foodflow-desktop.ps1
FILE1=start-foodflow.bat
"@

Set-Content -Path $sedPath -Value $sedContent -Encoding ASCII
& "$env:WINDIR\System32\iexpress.exe" /N $sedPath | Out-Null

if (Test-Path $targetExe) {
    Write-Output "Built: $targetExe"
}
else {
    Write-Error "EXE build failed."
    exit 1
}
