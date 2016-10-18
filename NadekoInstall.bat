@ECHO off
TITLE Downloading NadekoBot, please wait
::Setting convenient to read variables
SET root=%~dp0
SET build1=%root%NadekoInstall_Temp\NadekoBot\discord.net\src\Discord.Net\
SET build2=%root%NadekoInstall_Temp\NadekoBot\discord.net\src\Discord.Net.Commands\
SET build3=%root%NadekoInstall_Temp\NadekoBot\src\NadekoBot\
::Deleting traces of last setup for the sake of clean folders
IF EXIST "%root%NadekoInstall_Temp\" ( RMDIR "%root%NadekoInstall_Temp" /S /Q )
::Checks that both git and dotnet are installed and checks that windows 8 or newer is installed
dotnet --version >nul 2>&1 || GOTO :dotnet
git --version >nul 2>&1 || GOTO :git
FOR /F "tokens=4-7 delims=[.] " %%i IN ('VER') DO (IF %%i==Version (SET v=%%j.%%k) ELSE (set v=%%i.%%j))
IF %v% LSS "6.2" (GOTO :oldoperatingsystem)
::Creates the install directory to work in and get the current directory because spaces ruins everythin otherwise
CD /D %root%
SET rootdir=%cd%
MKDIR NadekoInstall_Temp
CD /D NadekoInstall_Temp
::Downloads the latest version of Nadeko
git clone -b 1.0 --recursive -v https://github.com/Kwoth/NadekoBot.git >nul
TITLE Installing NadekoBot, please wait
::Building Nadeko
CD /D %build1%
dotnet restore >nul 2>&1
dotnet build --configuration Release >nul 2>&1
CD /D %build2%
dotnet restore >nul 2>&1
dotnet build --configuration Release >nul 2>&1
CD /D %build3%
dotnet restore >nul 2>&1
dotnet build --configuration Release >nul 2>&1
::Copying music requriements
COPY %build3%libs\* %build3% >nul 2>&1
::Attempts to backup old files if they currently exist in the same folder as the batch file
IF EXIST "%root%NadekoBot\" (GOTO :backupinstall)
:freshinstall
	::Moves the NadekoBot folder to keep things tidy
	ROBOCOPY "%root%NadekoInstall_Temp" "%rootdir%" /E /MOVE >nul 2>&1
	GOTO :end
:backupinstall
	TITLE Backing up old files
	::Recursively copies all files and folders from NadekoBot to NadekoBot_Old
	ROBOCOPY "%root%NadekoBot" "%root%NadekoBot_Old" /E /MOVE >nul 2>&1
	ECHO.
	ECHO Old files backed up to NadekoBot_Old
	::Moves the setup Nadeko folder and deletes the remaining folders
	ROBOCOPY "%root%NadekoInstall_Temp" "%rootdir%" /E /MOVE >nul 2>&1
	CMD /C RMDIR "%root%NadekoInstall_Temp" /S /Q >nul 2>&1
	::Copies the credentials and database from the backed up data to the new folder
	COPY "%root%NadekoBot_Old\src\NadekoBot\credentials.json" "%root%NadekoBot\src\NadekoBot\credentials.json" >nul 2>&1
	ECHO.
	ECHO credentials.json copied to new folder
	CMD /C COPY "%root%NadekoBot_Old\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db" "%root%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db" >nul 2>&1
	ECHO.
	ECHO NadekoBot.db copied to new folder
	GOTO :end
:dotnet
	::Terminates the batch script if it can't run dotnet --version
	TITLE Error!
	ECHO dotnet not found, make sure it's been installed as per the guides instructions!
	ECHO Press any key to exit.
	CD /D "%root%" >nul 2>&1
	PAUSE >nul 2>&1
	GOTO :EOF
:git
	::Terminates the batch script if it can't run git --version
	TITLE Error!
	ECHO git not found, make sure it's been installed as per the guides instructions!
	ECHO Press any key to exit.
	CD /D "%root%"
	PAUSE >nul 2>&1
	GOTO :EOF
:oldoperatingsystem
	::Terminatesd the batch script if running on Windows 7 or older
	TITLE Error!
	ECHO You are using a version of windows too old for NadekoBot
	Echo Press any key to exit.
	CD /D "%root%"
	PAUSE >nul 2>&1
	GOTO :EOF
:end
	::Normal execution of end of script
	TITLE Installation complete!
	ECHO.
	ECHO Installation complete, press any key to close this window!
	CD /D "%root%"
	PAUSE >nul 2>&1
