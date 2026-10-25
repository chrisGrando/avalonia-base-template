@echo off
:: Menu lines text
set txt_menu_header_1="##################################"
set txt_menu_header_2="#    Compilation Options Menu    #"
set txt_menu_header_3="##################################"
set txt_menu_option_1="[1] Windows X64"
set txt_menu_option_2="[2] Windows ARM64"
set txt_menu_option_3="[3] Linux X64"
set txt_menu_option_4="[4] Linux ARM64"
set txt_menu_option_5="[5] MacOSX X64"
set txt_menu_option_6="[6] MacOSX ARM64"
set txt_menu_option_7="[x] Quit"
set txt_menu_hint="Type below the option ID of the corresponding platform and architecture you wish to build this project for:"

:: Menu rendering
echo %txt_menu_header_1:~1,-1%
echo %txt_menu_header_2:~1,-1%
echo %txt_menu_header_3:~1,-1%
echo.
echo %txt_menu_option_1:~1,-1%
echo %txt_menu_option_2:~1,-1%
echo %txt_menu_option_3:~1,-1%
echo %txt_menu_option_4:~1,-1%
echo %txt_menu_option_5:~1,-1%
echo %txt_menu_option_6:~1,-1%
echo %txt_menu_option_7:~1,-1%
echo.
echo %txt_menu_hint:~1,-1%

:: Get user choice
choice /n /c 123456x /m "> "

:: Setup runtime and architecture IDs
set runtime_id=nul
set target_id=nul

if %errorlevel% EQU 1 (
	set runtime_id=win-x64
	set target_id=x64
) else if %errorlevel% EQU 2 (
	set runtime_id=win-arm64
	set target_id=arm64
) else if %errorlevel% EQU 3 (
	set runtime_id=linux-x64
	set target_id=x64
) else if %errorlevel% EQU 4 (
	set runtime_id=linux-arm64
	set target_id=arm64
) else if %errorlevel% EQU 5 (
	set runtime_id=osx-x64
	set target_id=x64
) else if %errorlevel% EQU 6 (
	set runtime_id=osx-arm64
	set target_id=arm64
) else (
	:: Quit script
	goto :EOF
)

:: Enter project folder
cd %~dp0

:: Build project
for %%F in (*.sln) do (
	call dotnet clean
	call dotnet restore
	call dotnet msbuild -t:Restore;Rebuild -p:Configuration=Release;RuntimeIdentifier=%runtime_id%;PlatformTarget=%target_id% %%F
	goto :DONE
)

:DONE
pause
