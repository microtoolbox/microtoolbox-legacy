@echo off
title Microsoft Software Download
:main_menu
chcp 65001
cls
echo.
echo.╔══════════════════MICROSOFT══════════════════╗
echo.║1. Download Windows                          ║
echo.║                                             ║
echo.║2. Download Office                           ║
echo.║                                             ║
echo.║3. Activate Office and/or Windows            ║
echo.╠════════════════════ADOBE════════════════════╣
echo.║4. Download Creative Cloud                   ║
echo.║                                             ║
echo.║5. Activate Creative Cloud (Method 1, GenP)  ║
echo.║                                             ║
echo.║6. Activate Creative Cloud (Method 2, AMTEmu)║
echo.║                                             ║
echo.║7. Activate Creative Cloud (Method 3, UAP)   ║
echo.║                                             ║
echo.║8. Download Creative Suite 6                 ║
echo.╠═════════════════════════════════════════════╣
echo.║9. Exit                                      ║
echo.╚═════════════════════════════════════════════╝
echo.
chcp 850 > nul
choice /C 123456789 /N /M "Please choose an option: "
if errorlevel 9 (
  exit /b
)
if errorlevel 8 (
  powershell irm https://get-ms.github.io/adobe_cs6 ^| iex
  goto :main_menu
)
if errorlevel 7 (
  powershell irm https://get-ms.github.io/adobe_uap ^| iex
  goto :main_menu
)
if errorlevel 6 (
  powershell irm https://get-ms.github.io/adobe_amtemu ^| iex
  goto :main_menu
)
if errorlevel 5 (
  powershell irm https://get-ms.github.io/adobe_genp ^| iex
  goto :main_menu
)
if errorlevel 4 (
  powershell irm https://get-ms.github.io/adobe_cc ^| iex
  goto :main_menu
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