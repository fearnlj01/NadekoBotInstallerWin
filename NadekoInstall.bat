@ECHO off
@TITLE Installing NadekoBot, please wait
SET rootdir=%cd%
IF EXIST %rootdir%\NadekoInstall_Temp\ (
RMDIR %rootdir%\NadekoInstall_Temp /S /Q
)
MKDIR NadekoInstall_Temp
CD NadekoInstall_Temp
git clone -b 1.0 --recursive https://github.com/Kwoth/NadekoBot.git
dotnet restore
CD NadekoBot\src\NadekoBot\
dotnet build --configuration Release
IF EXIST %rootdir%\NadekoBot\ (
ROBOCOPY %rootdir%\NadekoBot\ %rootdir%\NadekoBot_Old\ /E /NFL /NDL /NJH /NJS /NC /NS /NP
ECHO Old files backed up to NadekoBot_Old
TIMEOUT /t 10 /nobreak
RMDIR %rootdir%\NadekoBot /S /Q
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\NadekoBot /E /MOVE /NFL /NDL /NJH /NJS /NC /NS /NP
TIMEOUT /t 10 /nobreak
RMDIR %rootdir%\NadekoInstall_Temp /S /Q 
) ELSE (
ROBOCOPY %rootdir%\NadekoInstall_Temp %rootdir%\NadekoBot /E /MOVE /NFL /NDL /NJH /NJS /NC /NS /NP
)
@TITLE Installation complete!
ECHO Installation complete
pause