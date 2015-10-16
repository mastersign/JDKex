@ECHO OFF
SET src=%~f1
SET tmp=.\tmp
SET result=.\result
SET open_dir=%~n1
SET zip_file=%~n1.zip

IF NOT EXIST "%src%" (
    ECHO Source file not found: '%src%'. Aborting.
    EXIT /B 1
)

WHERE 7z >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    ECHO 7zip is not installed. Aborting.
    EXIT /B 1
)

PUSHD "%~dp0"

IF EXIST "%tmp%\" RMDIR /S /Q "%tmp%"
MKDIR "%tmp%"
ECHO Extracting installer %src%
7z x "-o%tmp%" "%src%"
IF NOT EXIST "%tmp%\tools.zip" (
    ECHO Did not find the expected content. Aborting.
    EXIT /B 1
)
POPD

IF NOT EXIST "%result%\" MKDIR "%result%"
IF EXIST "%result%\%open_dir%\" RMDIR /S /Q "%result%\%open_dir%"
7z x "-o%result%\%open_dir%" "-x!lib\missioncontrol*" "-x!bin\jmc.exe" "-x!javafx-src.zip" "-x!db*" "%tmp%\tools.zip"
RMDIR /S /Q "%tmp%"

PUSHD "%result%\%open_dir%"
FOR /r %%x IN (*.pack) DO (
    ECHO Converting pack file: '%%x' ...
    .\bin\unpack200 -r "%%x" "%%~dx%%~px%%~nx.jar"
)
POPD

ECHO Creating ZIP-Archive: '%result%\%zip_file%' ...
IF EXIST "%result%\%zip_file%" DEL "%result%\%zip_file%"
7z a -tzip -mx9 -r "%result%\%zip_file%" "%result%\%open_dir%\*"

POPD

ECHO Finished.
