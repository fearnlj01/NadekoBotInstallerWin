@ECHO off
@TITLE NadekoBot
CD NadekoBot_Old\src\NadekoBot
dotnet run --configuration Release
ECHO NadekoBot has been succesfully stopped, press any key to close this window.
TITLE NadekoBot - Stopped
CD %~dp0
PAUSE >nul 2>&1
