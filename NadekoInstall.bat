@ECHO off
@TITLE Downloading NadekoBot, please wait
SET rootdir=%CD%
SET nadeko=%CD%\NadekoInstall_Temp\NadekoBot\
SET build1=%nadeko%discord.net\src\Discord.Net
SET build2=%nadeko%discord.net\src\Discord.Net.Commands
SET build3=%nadeko%src\NadekoBot
IF EXIST %rootdir%\NadekoInstall_Temp\ (
RMDIR %rootdir%\NadekoInstall_Temp /S /Q 2> nul
)
MKDIR NadekoInstall_Temp
CD NadekoInstall_Temp
git clone -b 1.0 --recursive -v https://github.com/Kwoth/NadekoBot.git >nul
@TITLE Installing NadekoBot, please wait
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
@TITLE Backing up old files
ROBOCOPY %rootdir%\NadekoBot\ %rootdir%\NadekoBot_Old\ /E >nul 2>&1
ECHO $'Old files backed up to NadekoBot_Old\n'
CMD /C RMDIR %rootdir%\NadekoBot /S /Q >nul 2>&1
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\ /E /MOVE >nul 2>&1
CMD /C RMDIR %rootdir%\NadekoInstall_Temp /S /Q >nul 2>&1
COPY %rootdir%\NadekoBot_Old\src\NadekoBot\credentials.json %rootdir%\NadekoBot\src\NadekoBot\credentials.json >nul 2>&1
ECHO $'credentials.json copied to new folder\n'
CMD /C COPY %rootdir%\NadekoBot_Old\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db %rootdir%\NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db >nul 2>&1
ECHO $'NadekoBot.db copied to new folder\n'
) ELSE (
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\ /E /MOVE >nul 2>&1
)
@TITLE Installation complete!
ECHO Installation complete
PAUSE
