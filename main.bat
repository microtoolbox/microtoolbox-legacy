@echo off
title Microsoft Software Download
:main_menu
cls
echo.
echo.1. Download Windows
echo.
echo.2. Download Office
echo.
echo.3. Activate Office and/or Windows
echo.
echo.4. Exit
echo.
choice /C 1234 /N /M "Please choose an option: "
if errorlevel 4 (
  exit /b
)
if errorlevel 3 (
  powershell irm https://get-ms.github.io/activate ^| iex
  goto :main_menu
)
if errorlevel 2 (
  powershell irm https://get-ms.github.io/office ^| iex
  goto :main_menu
)
if errorlevel 1 (
  powershell irm https://get-ms.github.io/windows ^| iex
  goto :main_menu
)
goto :main_menu