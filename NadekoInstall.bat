@ECHO off
@TITLE Installing NadekoBot, please wait
SET rootdir=%cd%
IF EXIST %rootdir%\NadekoInstall_Temp\ (
RMDIR %rootdir%\NadekoInstall_Temp /S /Q
)
MKDIR NadekoInstall_Temp
CD NadekoInstall_Temp
git clone -b 1.0 --recursive https://github.com/Kwoth/NadekoBot.git
dotnet restore > log:nul
CD NadekoBot\src\NadekoBot\
dotnet build --configuration Release
IF EXIST %rootdir%\NadekoBot\ (
ROBOCOPY %rootdir%\NadekoBot\ %rootdir%\NadekoBot_Old\ /E > log:nul
ECHO Old files backed up to NadekoBot_Old
CMD /C RMDIR %rootdir%\NadekoBot /S /Q
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\ /E /MOVE > log:nul
CMD /C RMDIR %rootdir%\NadekoInstall_Temp /S /Q
COPY %rootdir%\NadekoBot_Old\src\NadekoBot\credentials.json %rootdir%\NadekoBot\src\NadekoBot\credentials.json
CMD /C COPY %rootdir%\NadekoBot_Old\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db %rootdir%\NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db
) ELSE (
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\ /E /MOVE > log:nul
)
@TITLE Installation complete!
ECHO Installation complete
pause
