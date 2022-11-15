@Echo off
powershell iwr https://get-ms.github.io/batbox.exe -o '%temp%\batbox.exe'
powershell iwr https://get-ms.github.io/getinput.exe -o '%temp%\getinput.exe'
set "batbox=%temp%\batbox.exe"
set "getinput=%temp%\getinput.exe"
Mode 48,15
Title Software Download
"%Batbox%" /h 0

:MainMenu
cls
Call :Button 17 4 "Microsoft" 19 8 "Adobe" # Press
"%Getinput%" /m %Press% /h 70

:: Check for the pressed button 
if %errorlevel%==1 (goto :Microsoft)
if %errorlevel%==2 (goto :Adobe)
if %errorlevel%==3 (exit)
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
powershell irm https://get-ms.github.io/windows ^| iex
exit /b

:Office
cls
powershell irm https://get-ms.github.io/office ^| iex
exit /b

:MSActivation
cls
powershell irm https://get-ms.github.io/activate ^| iex
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

:CreativeCloud
cls
powershell irm https://get-ms.github.io/adobe_cc ^| iex
exit /b

:CreativeSuite6
cls
powershell irm https://get-ms.github.io/adobe_cs6 ^| iex
exit /b

:GenP
cls
powershell irm https://get-ms.github.io/adobe_genp ^| iex
exit /b

:AMTEmu
cls
powershell irm https://get-ms.github.io/adobe_amtemu ^| iex
exit /b

:UAP
cls
powershell irm https://get-ms.github.io/adobe_uap ^| iex
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