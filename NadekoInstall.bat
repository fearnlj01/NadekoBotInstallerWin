@ECHO off
TITLE Downloading NadekoBot, please wait
SET rootdir=%cd%
SET nadeko=%cd%\NadekoInstall_Temp\NadekoBot\
SET build1=%nadeko%discord.net\src\Discord.Net
SET build2=%nadeko%discord.net\src\Discord.Net.Commands
SET build3=%nadeko%src\NadekoBot
IF EXIST %rootdir%\NadekoInstall_Temp\ (
RMDIR %rootdir%\NadekoInstall_Temp /S /Q
)
dotnet --version >nul 2>&1 || GOTO :dotnet
git --version >nul 2>&1 || GOTO :git
MKDIR NadekoInstall_Temp
CD NadekoInstall_Temp
git clone -b 1.0 --recursive -v https://github.com/Kwoth/NadekoBot.git >nul
TITLE Installing NadekoBot, please wait
CD %build1%
dotnet restore >nul 2>&1
dotnet build --configuration Release >nul 2>&1
CD %build2%
dotnet restore >nul 2>&1
dotnet build --configuration Release >nul 2>&1
CD %build3%
dotnet restore >nul 2>&1
dotnet build --configuration Release >nul 2>&1
IF EXIST %rootdir%\NadekoBot\ (
TITLE Backing up old files
ROBOCOPY %rootdir%\NadekoBot\ %rootdir%\NadekoBot_Old\ /E >nul 2>&1
ECHO.
ECHO Old files backed up to NadekoBot_Old
CMD /C RMDIR %rootdir%\NadekoBot /S /Q >nul 2>&1
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\ /E /MOVE >nul 2>&1
CMD /C RMDIR %rootdir%\NadekoInstall_Temp /S /Q >nul 2>&1
COPY %rootdir%\NadekoBot_Old\src\NadekoBot\credentials.json %rootdir%\NadekoBot\src\NadekoBot\credentials.json >nul 2>&1
ECHO.
ECHO credentials.json copied to new folder
CMD /C COPY %rootdir%\NadekoBot_Old\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db %rootdir%\NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db >nul 2>&1
ECHO.
ECHO NadekoBot.db copied to new folder
) ELSE (
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\ /E /MOVE >nul 2>&1
)
GOTO :end
:dotnet
TITLE Error!
ECHO dotnet not found, make sure it's been installed as per the guides instructions!
ECHO Press any key to exit.
PAUSE >nul 2>&1
CD $rootdir%
GOTO :EOF
:git
TITLE Error!
ECHO git not found, make sure it's been installed as per the guides instructions!
ECHO Press any key to exit.
PAUSE >nul 2>&1
CD $rootdir%
GOTO :EOF
:end
TITLE Installation complete!
ECHO.
ECHO Installation complete, press any key to close this window!
PAUSE >nul 2>&1
CD %rootdir%
