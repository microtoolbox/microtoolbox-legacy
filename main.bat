@echo off
setlocal enabledelayedexpansion
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/batbox.exe -OutFile '%temp%\batbox.exe'
set "batbox=%temp%\batbox.exe"
set "getinput=%temp%\getinput.exe"
Mode 48,17
Title Software Download
"%Batbox%" /h 0
set "array="
set "array0="
set arrayindex=0
set entry=0
set entries=8
set "entrydata_0=                    Windows                   "
set "entrydata_1=                    Office                    "
set "entrydata_2=                   Adobe CC                   "
set "entrydata_3=                   Adobe CS6                  "
set "entrydata_4=                  StartIsBack                 "
set "entrydata_5=                    Start11                   "
set "func_5=install_start11"
set "entrydata_6=                     Notes                    "
set "entrydata_7=                   Defender                   "
set "func_7=defender"
set "entrydata_8=                  W8.0 Certs                  "
set "func_8=install_w8_certs"

set entries_0=1
set "entrydata_0_0=                Install Windows               "
set "func_0_0=install_windows"
set "entrydata_0_1=               Activate with MAS              "
set "func_0_1=MSActivation"
set "entrydata_0_2=               Activate with KMS              "&rem NOT AVAILABLE

set entries_1=1
set "entrydata_1_0=                Install Office                "
set "func_1_0=install_office"
set "entrydata_1_1=               Activate with MAS              "
set "func_1_1=MSActivation"

set entries_2=3
set "entrydata_2_0=               Install Adobe CC               "
set "func_2_0=CreativeCloud"
set "entrydata_2_1=              Activate with GenP              "
set "func_2_1=GenP"
set "entrydata_2_2=               Activate with UAP              "
set "func_2_2=UAP"
set "entrydata_2_3=             Activate with AMTEmu             "
set "func_2_3=AMTEmu"

set entries_3=2
set "entrydata_3_0=               Install Adobe CS6              "
set "func_3_0=CreativeCloud"
set "entrydata_3_1=               Activate with UAP              "
set "func_3_1=UAP"
set "entrydata_3_2=             Activate with AMTEmu             "
set "func_3_2=AMTEmu"

goto :home

:install_windows
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/windows ^| iex
exit /b

:install_office
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/office ^| iex
exit /b

:MSActivation
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/activate ^| iex
exit /b

:SIB
cls
ver|find "6.2"
if not errorlevel 1 (
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://www.startisback.com/StartIsBack_setup.exe -OutFile "%WinDir%\SIB.exe"
  start "" "%WinDir%\SIB.exe"
)
ver|find "6.3"
if not errorlevel 1 (
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://www.startisback.com/StartIsBackPlus_setup.exe -OutFile "%WinDir%\SIB.exe"
  start "" "%WinDir%\SIB.exe"
)
ver|find "10.0"
if not errorlevel 1 (
  wmic os get caption /value|findstr /C:"Microsoft Windows 10"
  if not errorlevel 1 (
    powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://www.startisback.com/StartIsBackPlusPlus_setup.exe -OutFile "%WinDir%\SIB.exe"
    start "" "%WinDir%\SIB.exe"
  ) else (
    curl https://www.startallback.com/download.php -L -o "%WinDir%\SAB.exe"
    start "" "%WinDir%\SAB.exe"
  )
)
exit /b

:ActivateSIB
wmic os get caption /value|findstr /C:"Microsoft Windows 10"
if not errorlevel 1 (
  powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/msimg32.dll -OutFile "${Env:ProgramFiles(x86)}\StartIsBack\msimg32.dll"
  taskkill /f /im explorer.exe
  start explorer
) else (
  curl https://microtoolbox.github.io/StartAllBack_3.x_Patch.exe -o "%temp%\StartAllBack_3.x_Patch.exe"
  start /wait "" "%temp%\StartAllBack_3.x_Patch.exe"
  del /F /Q "%temp%\StartAllBack_3.x_Patch.exe"
)
exit /b

:defender
powershell Add-MpPreference -ExclusionPath '%WinDir%\dcontrol.exe' >nul 2>&1
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/dcontrol.exe -OutFile "%WinDir%\dcontrol.exe"
powershell Add-MpPreference -ExclusionPath '%WinDir%\dcontrol.exe' >nul 2>&1
start "" "%WinDir%\dcontrol.exe"
exit /b

:CreativeCloud
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/adobe_cc ^| iex
exit /b

:CreativeSuite6
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/adobe_cs6 ^| iex
exit /b

:GenP
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/adobe_genp ^| iex
exit /b

:AMTEmu
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/adobe_amtemu ^| iex
exit /b

:UAP
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/adobe_uap ^| iex
exit /b

:install_w8_certs
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/Windows8-RT-KB3004394-x64.msu -OutFile "${Env:temp}\Windows8-RT-KB3004394-x64.msu"
start /wait "" "%temp%\Windows8-RT-KB3004394-x64.msu"
exit /b

:install_start11
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/Start11.exe  -OutFile "${Env:WinDir}\Start11.exe"
start "" "%WinDir%\Start11.exe"
exit /b










:home
cls
set /a centerentries=entries-7
if %entry% LSS 7 (
  set /a entrystart=0
  set /a entryend=15
) else if %entry% GTR %centerentries% (
  set /a entrystart=entries-15
  set /a entryend=entries
) else (
  set /a entrystart=entry-7
  set /a entryend=entry+8
)
if %entrystart% LSS 0 set entrystart=0
if %entryend% GTR %entries% set entryend=%entries%
for /l %%i in (%entrystart%,1,%entryend%) do (
  if not %%i GTR !entries%array%! if "%%i"=="%entry%" (
    "%Batbox%" /c 0x70 /a 124 /d "!entrydata%array%_%%i!" /a 124 /c 0x07
  ) else (
    "%Batbox%" /c 0x07 /a 124 /d "!entrydata%array%_%%i!" /a 124 /c 0x07
  )
)
"%batbox%" /g 0 16 /d "W=Up     S=Down     A=Back     D=Okay"
choice /C WASD /N>nul
if errorlevel 255 (
  ::choice failure
  goto :home
) else if errorlevel 4 (
  ::D
  if DEFINED entries%array%_%entry% (
    set "array=%array%_%entry%"
    set /a arrayindex=arrayindex+1
    set "array%arrayindex%=%array%"
  ) else if DEFINED func%array%_%entry% (
    call :!func%array%_%entry%!
  )
  set entry=0
  goto :home
) else if errorlevel 3 (
  ::S
  if not "%entry%"=="!entries%array%!" set /a entry=entry+1
  goto :home
) else if errorlevel 2 (
  ::A
  set /a arrayindex=arrayindex-1
  if !arrayindex! LSS 0 set arrayindex=0
  call set array=%%array!arrayindex!%%
  set entry=0
  goto :home
) else if errorlevel 1 (
  ::W
  if not "%entry%"=="0" set /a entry=entry-1
  goto :home
) else if errorlevel 0 (
  ::Ctrl+C
  goto :home
)