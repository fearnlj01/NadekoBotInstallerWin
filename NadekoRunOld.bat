@echo off
@title NadekoBot
CD NadekoBot_Old\src\NadekoBot
dotnet run --configuration Release
ECHO NadekoBot has been succesfully stopped, press any key to close this window.
CD %~dp0
PAUSE >nul 2>&1
