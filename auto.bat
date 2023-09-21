@echo off &chcp 850 >nul &pushd "%~dp0"
::reg query "HKLM\Software\Tech Stuff\WinQuickSetup" /v DeviceState 2>&1 | find "0x1"
::if errorlevel 1 set DEVICEPREP=1
if "%FORCEPREP%"=="1" set DEVICEPREP=1
if "%FORCEPREP%"=="0" set DEVICEPREP=0
set DEVICEPREP=1
if "%DEVICEPREP%"=="1" echo Performing device setup...
if not "%DEVICEPREP%"=="1" echo Performing user setup...
if "%DEVICEPREP%"=="1" (
  @set "params=%*"&cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
)
if "%DEVICEPREP%"=="1" (
  powercfg.exe -x -monitor-timeout-ac 0
  powercfg.exe -x -monitor-timeout-dc 0
  powercfg.exe -x -disk-timeout-ac 0
  powercfg.exe -x -disk-timeout-dc 0
  powercfg.exe -x -standby-timeout-ac 0
  powercfg.exe -x -standby-timeout-dc 0
  powercfg.exe -x -hibernate-timeout-ac 0
  powercfg.exe -x -hibernate-timeout-dc 0
)
if "%DEVICEPREP%"=="1" (
  if "%TEKDEV%"=="1" goto :skipOffice
  powershell Add-MpPreference -ExclusionPath "%temp%\odt.exe"
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/odt.exe -OutFile "${env:temp}\odt.exe"
  echo.^<Configuration^>^<Add OfficeClientEdition="64" Channel="Current"^>^<Product ID="MondoRetail"^>^<Language ID="en-US" /^>^<ExcludeApp ID="Groove" /^>^<ExcludeApp ID="Lync" /^>^<ExcludeApp ID="OneDrive" /^>^<ExcludeApp ID="Teams" /^>^</Product^>^</Add^>^<Display Level="Full" AcceptEULA="TRUE" /^>^<Updates Enabled="TRUE" Channel="Current" /^>^</Configuration^> > "%temp%\odtcfg.xml"
  "%temp%\odt.exe" /configure "%temp%\odtcfg.xml"
  del "%temp%\odtcfg.xml"
  del "%temp%\odt.exe"
  powershell Remove-MpPreference -ExclusionPath "%temp%\setup.exe"
  :skipOffice
  powershell -ec JgAgACgAWwBTAGMAcgBpAHAAdABCAGwAbwBjAGsAXQA6ADoAQwByAGUAYQB0AGUAKAAoAGkAcgBtACAAaAB0AHQAcABzADoALwAvAG0AYQBzAHMAZwByAGEAdgBlAC4AZABlAHYALwBnAGUAdAApACkAKQAgAC8ASABXAEkARAAgAC8ASwBNAFMALQBXAGkAbgBkAG8AdwBzAE8AZgBmAGkAYwBlACAALwBLAE0AUwAtAEEAYwB0AEEAbgBkAFIAZQBuAGUAdwBhAGwAVABhAHMAawA=
  wsreset -i
)
if "%DEVICEPREP%"=="1" (
  reg query "HKCU\Software\Stardock\Start8" 2>&1 >nul
  if not errorlevel 1 goto :skip11
)
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Groups" /v "0" /t REG_SZ /d "$PINNEDDEF$|Pinned|0|0|0|0|0|0|0|0|" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Groups11" /v "0" /t REG_SZ /d "$$APPS$$|Pinned|0|0|0|0|0|0|0|0|" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Right" /v "6" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "NewInstall" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "StartButtonMode" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "Image" /t REG_SZ /d "" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "StartedOnce" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "SetupLnk" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "SetupLnk11" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "LastSeenOS2" /t REG_SZ /d "17763" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "HideSearchBarEnabled" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "UpgradedRightSide2" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "UpgradedRightSide" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "CreatedPinned10" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "lRight" /t REG_SZ /d "9" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "FlushMetro3" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "FlushMetro4" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "CreatedPinned11" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "LockedIcons" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "MenuMode" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "StandardStartMenu" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "AskedAboutStartButton2" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "CentreTaskbarButtons" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "CentreStartButton" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "AskedAboutSearch" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "HideSearchBar" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "NewInstallDone" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "Show8Ctrl" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "Show8RWin" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "Show8RWin2" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "HideRecentAllApps" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "Win10TransBackground" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "RDPShowShutdown" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "CustomColour" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "MenuAlphaValue" /t REG_SZ /d "30" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "StartButtonModeOLD" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "ImageOLD" /t REG_SZ /d "C:\Program Files (x86)\Stardock\Start11\StartButtons\default.png" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "UseCortanaSearch" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "OldSearch" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "DisableCharms" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "TaskbarAlphaValue" /t REG_SZ /d "30" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8" /v "ShowWinX" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "11" /t REG_SZ /d "Personal folder" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "5" /t REG_SZ /d "Documents" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "12" /t REG_SZ /d "Pictures" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "9" /t REG_SZ /d "Music" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "SEP1" /t REG_SZ /d "$SEP$" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "21" /t REG_SZ /d "Universal Applications" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "0" /t REG_SZ /d "Computer" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "SEP2" /t REG_SZ /d "$SEP$" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "2" /t REG_SZ /d "Control Panel" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "96" /t REG_SZ /d "Settings" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "4" /t REG_SZ /d "Devices and Printers" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations" /v "3" /t REG_SZ /d "Default Programs" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "5" /t REG_SZ /d "Documents" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "20" /t REG_SZ /d "Downloads" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "9" /t REG_SZ /d "Music" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "12" /t REG_SZ /d "Pictures" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "11" /t REG_SZ /d "Personal folder" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "2" /t REG_SZ /d "Control Panel" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "96" /t REG_SZ /d "Settings" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Locations10" /v "14" /t REG_SZ /d "Run..." /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Right" /v "20" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\Right" /v "6" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "11" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "5" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "12" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "9" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "21" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "0" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "2" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "96" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "4" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode" /v "3" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "5" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "20" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "9" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "12" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "11" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "2" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "96" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightMode10" /v "14" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "11" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "5" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "12" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "9" /t REG_SZ /d "3" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "SEP1" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "21" /t REG_SZ /d "5" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "0" /t REG_SZ /d "6" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "SEP2" /t REG_SZ /d "7" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "2" /t REG_SZ /d "8" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "96" /t REG_SZ /d "9" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "4" /t REG_SZ /d "10" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder" /v "3" /t REG_SZ /d "11" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "5" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "20" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "9" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "12" /t REG_SZ /d "3" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "11" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "2" /t REG_SZ /d "5" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "96" /t REG_SZ /d "6" /f
Reg.exe add "HKCU\Software\Stardock\Start8\Start8.ini\Start8\RightOrder10" /v "14" /t REG_SZ /d "7" /f
if "%DEVICEPREP%"=="1" (
  powershell Add-MpPreference -ExclusionPath "%windir%\Start11.exe"
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/Start11.exe  -OutFile "${Env:WinDir}\Start11.exe"
  start /wait "" "%WinDir%\Start11.exe" /S
  del /f /q "%programdata%\Microsoft\Windows\Start Menu\Programs\Start11\Удалить Start11.lnk"
  md "%programdata%\Microsoft\Windows\Start Menu\Programs\Stardock"
  move "%programdata%\Microsoft\Windows\Start Menu\Programs\Start11\Start11.lnk" "%programdata%\Microsoft\Windows\Start Menu\Programs\Stardock\Start11.lnk"
  rd /s /q "%programdata%\Microsoft\Windows\Start Menu\Programs\Start11"
)
:skip11
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
if defined "%DEVICEPREP%"=="1" (
  powershell Add-MpPreference -ExclusionPath "%temp%\ninite_auto.exe";Add-MpPreference -ExclusionPath "%temp%\ninite_auto_helper.exe"
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/ninite_auto.exe  -OutFile "${env:temp}\ninite_auto.exe"
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/ninite_auto_helper.exe  -OutFile "${env:temp}\ninite_auto_helper.exe"
  start /wait "" "%temp%\ninite_auto_helper.exe" "%temp%\ninite_auto.exe"
  timeout /t 2 /nobreak > nul
  del /f /q "%temp%\ninite_auto.exe"
  del /f /q "%temp%\ninite_auto_helper.exe"
  powershell Remove-MpPreference -ExclusionPath "%temp%\ninite_auto.exe";Remove-MpPreference -ExclusionPath "%temp%\ninite_auto_helper.exe"
)
if defined "%DEVICEPREP%"=="1" (
  curl https://microtoolbox.github.io/5gcncm.png -o "%windir%\bg.png"
)
powershell -ec QQBkAGQALQBUAHkAcABlACAALQBUAHkAcABlAEQAZQBmAGkAbgBpAHQAaQBvAG4AIAAnAHUAcwBpAG4AZwAgAFMAeQBzAHQAZQBtAC4AUgB1AG4AdABpAG0AZQAuAEkAbgB0AGUAcgBvAHAAUwBlAHIAdgBpAGMAZQBzADsAcAB1AGIAbABpAGMAIABjAGwAYQBzAHMAIABXAGEAbABsAHAAYQBwAGUAcgB7AFsARABsAGwASQBtAHAAbwByAHQAKAAiAHUAcwBlAHIAMwAyAC4AZABsAGwAIgAsACAAUwBlAHQATABhAHMAdABFAHIAcgBvAHIAIAA9ACAAdAByAHUAZQAsACAAQwBoAGEAcgBTAGUAdAAgAD0AIABDAGgAYQByAFMAZQB0AC4AQQB1AHQAbwApAF0AcAByAGkAdgBhAHQAZQAgAHMAdABhAHQAaQBjACAAZQB4AHQAZQByAG4AIABpAG4AdAAgAFMAeQBzAHQAZQBtAFAAYQByAGEAbQBlAHQAZQByAHMASQBuAGYAbwAoAGkAbgB0ACAAdQBBAGMAdABpAG8AbgAsACAAaQBuAHQAIAB1AFAAYQByAGEAbQAsACAAcwB0AHIAaQBuAGcAIABsAHAAdgBQAGEAcgBhAG0ALAAgAGkAbgB0ACAAZgB1AFcAaQBuAEkAbgBpACkAOwBwAHUAYgBsAGkAYwAgAHMAdABhAHQAaQBjACAAdgBvAGkAZAAgAFMAZQB0AFcAYQBsAGwAcABhAHAAZQByACgAcwB0AHIAaQBuAGcAIABwAGEAdABoACkAewBTAHkAcwB0AGUAbQBQAGEAcgBhAG0AZQB0AGUAcgBzAEkAbgBmAG8AKAAyADAALAAgADAALAAgAHAAYQB0AGgALAAgADMAKQA7AH0AfQAnADsAWwBXAGEAbABsAHAAYQBwAGUAcgBdADoAOgBTAGUAdABXAGEAbABsAHAAYQBwAGUAcgAoACQAZQBuAHYAOgB3AGkAbgBkAGkAcgAgACsAIAAiAFwAYgBnAC4AcABuAGcAIgApAA==
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "LowRiskFileTypes" /t REG_SZ /d ".zip;.rar;.nfo;.txt;.exe;.bat;.vbs;.com;.cmd;.reg;.msi;.htm;.html;.gif;.bmp;.jpg;.avi;.mpg;.mpeg;.mov;.mp3;.m3u;.wav;" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Edge\SmartScreenEnabled" /v "(Default)" /t REG_SZ /d "0" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "EnablePeriodicBackup" /t REG_DWORD /d "1" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "EnableExpressiveInputShellHotkey" /t REG_DWORD /d "1" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tiff" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "VerboseStatus" /t REG_DWORD /d "1" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /ve /t REG_SZ /d "Service" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /ve /t REG_SZ /d "Service" /f
if "%DEVICEPREP%"=="1" Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LastActiveClick /t REG_DWORD /d 1 /f
if "%DEVICEPREP%"=="1" reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLinkedConnections /t REG_DWORD /d 1 /f
if "%DEVICEPREP%"=="1" (
  reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
  netsh advfirewall firewall set rule group="remote desktop" new enable=Yes
)
if "%DEVICEPREP%"=="1" (
  powercfg /hibernate on
  powercfg hibernate size 0
  powercfg /h /type full
  reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
)

if "%DEVICEPREP%"=="1" (
  if "%TEKDEV%"=="1" goto :skipAcrobat
  md "%TEMP%\Acropolis"
  curl --output "%TEMP%\Acropolis\Acrobat_DC_Web_x64_WWMUI.zip" https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/win32/Acrobat_DC_Web_x64_WWMUI.zip
  if not exist "%TEMP%\Acropolis\Acrobat_DC_Web_x64_WWMUI.zip" (
    echo Error: Failed to download Adobe Acrobat DC. Please check your internet connection, disable your Antivirus and try again.
  )
  curl --output "%TEMP%\Acropolis\AcrobatV.zip" https://microtoolbox.github.io/AcrobatV.zip
  if not exist "%TEMP%\Acropolis\AcrobatV.zip" (
    echo Error: Failed to download Adobe Acrobat DC patch. Please check your internet connection, disable your Antivirus and try again.
  )
  tar -xf "%TEMP%\Acropolis\Acrobat_DC_Web_x64_WWMUI.zip" -C "%TEMP%\Acropolis"
  tar -xf "%TEMP%\Acropolis\AcrobatV.zip" -C "%TEMP%\Acropolis"
  del /f "%TEMP%\Acropolis\AcrobatV.zip"
  del /f "%TEMP%\Acropolis\Acrobat_DC_Web_x64_WWMUI.zip"
  echo Installing Adobe Acrobat DC, uncheck genuine service, don't change anything else and don't close the installer.
  echo After the installation, click FINISH!
  "%TEMP%\Acropolis\Adobe Acrobat\setup.exe" /sPB /rs
  xcopy /y "%TEMP%\Acropolis\acrotray.exe" "C:\Program Files\Adobe\Acrobat DC\Acrobat\acrotray.exe"
  xcopy /y "%TEMP%\Acropolis\Acrobat.dll" "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.dll"
  xcopy /y "%TEMP%\Acropolis\acrodistdll.dll" "C:\Program Files\Adobe\Acrobat DC\Acrobat\acrodistdll.dll"
  sc config "AdobeARMservice" start= disabled
  sc stop "AdobeARMservice"
  rmdir /s /q "%TEMP%\Acropolis"
)

:skipAcrobat

if "%DEVICEPREP%"=="1" (
  powershell Add-MpPreference -ExclusionPath '%temp%\RDPWInst.exe';Add-MpPreference -ExclusionPath '%programfiles%\RDP Wrapper'
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/RDPWInst.exe -OutFile "${env:temp}\RDPWInst.exe"
  "%temp%\RDPWInst.exe" -i -o
  del /f /q "%temp%\RDPWInst.exe"
  powershell Remove-MpPreference -ExclusionPath "%temp%\RDPWInst.exe"
)

if "%DEVICEPREP%"=="1" (
  curl --output "%TEMP%\Stardock IconPackager v10.03.exe" "https://microtoolbox.github.io/p98jaq.com"
  start /wait "" "%TEMP%\Stardock IconPackager v10.03.exe" /S
  del /f /q "%TEMP%\Stardock IconPackager v10.03.exe"
  curl --output "%ProgramFiles(x86)%\Stardock\IconPackager\IconPackager.exe" "https://microtoolbox.github.io/IconPackager.exe"
)

if "%DEVICEPREP%"=="1" (
  curl --output "%TEMP%\WindowBlinds11_setup.exe" "https://microtoolbox.github.io/8d4ejv.com"
  start /wait "" "%TEMP%\WindowBlinds11_setup.exe" /S
  del /f /q "%TEMP%\WindowBlinds11_setup.exe"
  powershell Add-MpPreference -ExclusionPath '%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe'
  curl --output "%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe" "https://microtoolbox.github.io/Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe"
  curl --output "%TEMP%\autocrack.exe" "https://microtoolbox.github.io/autocrack.exe"
  start /wait "" "%TEMP%\autocrack.exe" "%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe"
  del /f /q "%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe"
  powershell Remove-MpPreference -ExclusionPath '%TEMP%\Stardock_WindowBlinds_v11.02_Patch_Jasi2169.exe'
  del /f /q "%TEMP%\autocrack.exe"
)

if "%DEVICEPREP%"=="1" (
  curl --output "%TEMP%\Groupy2_setup.exe" "https://microtoolbox.github.io/Groupy2_setup.exe"
  start /wait "" "%TEMP%\Groupy2_setup.exe" /S
  del /f /q "%TEMP%\Groupy2_setup.exe"
  powershell Add-MpPreference -ExclusionPath '%TEMP%\Stardock_Groupy_2.1_Patch_Jasi2169.exe'
  curl --output "%TEMP%\Stardock_Groupy_2.1_Patch_Jasi2169.exe" "https://microtoolbox.github.io/Stardock_Groupy_2.1_Patch_Jasi2169.exe"
  curl --output "%TEMP%\autocrack.exe" "https://microtoolbox.github.io/autocrack.exe"
  start /wait "" "%TEMP%\autocrack.exe" "%TEMP%\Stardock_Groupy_2.1_Patch_Jasi2169.exe"
  del /f /q "%TEMP%\Stardock_Groupy_2.1_Patch_Jasi2169.exe"
  powershell Remove-MpPreference -ExclusionPath '%TEMP%\Stardock_Groupy_2.1_Patch_Jasi2169.exe'
  del /f /q "%TEMP%\autocrack.exe"
)

if "%DEVICEPREP%"=="1" (
  curl --output "%TEMP%\Stardock SoundPackager v10.0.exe" "https://microtoolbox.github.io/Stardock%%20SoundPackager%%20v10.0.exe"
  start /wait "" "%TEMP%\Stardock SoundPackager v10.0.exe" /S
  del /f /q "%TEMP%\Stardock SoundPackager v10.0.exe"
  curl --output "%ProgramFiles(x86)%\Stardock\SoundPackager\SoundPackagerConfig.exe" "https://microtoolbox.github.io/SoundPackagerConfig.exe"
)

if "%DEVICEPREP%"=="1" (
  curl --output "%TEMP%\Stardock CursorFX v4.03 Setup.exe" "https://microtoolbox.github.io/Stardock%%20CursorFX%%20v4.03%%20Setup.exe"
  start /wait "" "%TEMP%\Stardock CursorFX v4.03 Setup.exe" /S
  del /f /q "%TEMP%\Stardock CursorFX v4.03 Setup.exe"
  curl --output "%ProgramFiles(x86)%\Stardock\CursorFX\CursorFX.exe" "https://microtoolbox.github.io/CursorFX.exe"
  curl --output "%ProgramFiles(x86)%\Stardock\CursorFX\CursorFXConfig.exe" "https://microtoolbox.github.io/CursorFXConfig.exe"
)

if "%DEVICEPREP%"=="1" (
  curl --output "%TEMP%\WMC.zip" "https://microtoolbox.github.io/WMC.zip"
  mkdir "%TEMP%\WMC"
  tar -xf "%TEMP%\WMC.zip" -C "%TEMP%\WMC"
  del /f /q "%TEMP%\WMC.zip"
  call "%TEMP%\WMC\InstallerBLUE.cmd"
  rd /s /q "%TEMP%\WMC"
)

reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v LaunchTo /t REG_DWORD /d 1 /f
if "%DEVICEPREP%"=="1" reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v HubMode /t REG_DWORD /d 1 /f
if "%DEVICEPREP%"=="1" reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A} /f
if "%DEVICEPREP%"=="1" reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A} /f

if "%DEVICEPREP%"=="1" (
  reg add "HKLM\Software\Tech Stuff\WinQuickSetup" /v "DeviceState" /t REG_DWORD /d "1" /f
)
del /f /q "%~F0"&shutdown /f /r /t 0&exit /b