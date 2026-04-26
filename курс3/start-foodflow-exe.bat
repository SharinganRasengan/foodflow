@echo off
setlocal

set "APP_DIR=%~dp0"
set "APP_EXE=%APP_DIR%FoodFlowDesktop.exe"

if not exist "%APP_EXE%" (
  echo FoodFlowDesktop.exe was not found in:
  echo %APP_DIR%
  pause
  exit /b 1
)

start "" "%APP_EXE%"
