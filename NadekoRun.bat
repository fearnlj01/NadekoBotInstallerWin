@echo off
@title NadekoBot
CD NadekoBot\src\NadekoBot
dotnet run --configuration Release
ECHO NadekoBot has been succesfully stopped, press any key to close this window.
PAUSE >nul 2>&1
