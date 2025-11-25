@echo off
setlocal enabledelayedexpansion

REM Set default port if not specified
if not defined PORT set PORT=3000

REM Set debug environment variables
set RUBY_DEBUG_OPEN=true
set RUBY_DEBUG_LAZY=true

REM Start Rails server and Tailwind CSS watch in parallel
start "Rails Server" cmd /k bin\rails server
start "Tailwind CSS Watch" cmd /k bin\rails tailwindcss:watch

REM Keep the window open
pause
