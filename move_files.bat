@echo off                                    REM Prevents commands from displaying in console
setlocal EnableDelayedExpansion             REM Enables dynamic variable expansion

REM === Log File Setup ===
REM Creates a log file with format YYYYMMDD
set LOGFILE=move_files_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log

REM === Directory Configuration ===
REM Define source and destination paths
set SOURCE_DIR=C:\Users\andre\Documents\Git\move_files_and_folders\source
set DEST_DIR=C:\Users\andre\Documents\Git\move_files_and_folders\destination

REM === Directory Validation ===
REM Check if source exists, exit if it doesn't
REM Check if destination exists, create if it doesn't
if not exist "%SOURCE_DIR%" (
    echo Error: Source directory does not exist >> %LOGFILE%
    exit /b 1
)
if not exist "%DEST_DIR%" (
    echo Creating destination directory
    mkdir "%DEST_DIR%"
)

REM === Specific File Operation Example ===
REM Demonstrates moving a single specific file
echo Moving specific file
move "%SOURCE_DIR%\files\NWSS_Public_SARS-CoV-2_Wastewater_Metric_Data_20241231 - Copy.csv" "%DEST_DIR%\files"

REM === Bulk Copy Operations ===
REM Copy all files preserving directory structure (/E)
REM Create destination if needed (/I)
REM Suppress overwrite prompts (/Y)
echo Copying files from %SOURCE_DIR%\files to %DEST_DIR%\files
xcopy "%SOURCE_DIR%\files\*" "%DEST_DIR%\files\" /E /I /Y

REM === Move Operations ===
REM Move all files from source to destination
REM Uses wildcard (*) to select all files
echo Moving files from %SOURCE_DIR%\files to %DEST_DIR%\files
move %SOURCE_DIR%\files\* %DEST_DIR%\files

REM === Folder Move Operations ===
REM Iterates through folders using for loop
REM %%d represents each directory found
echo Moving folders from %SOURCE_DIR%\folders to %DEST_DIR%\folders
for /D %%d in (%SOURCE_DIR%\folders\*) do (
    move "%%d" "%DEST_DIR%\folders"
)

REM === File Type Filtering Example ===
REM Demonstrates moving only specific file types
REM Uses *.csv to filter for CSV files only
echo Moving only CSV files
move "%SOURCE_DIR%\files\*.csv" "%DEST_DIR%\files"

REM === Date-Based Operations ===
REM Moves files modified in last 7 days
REM /D -7 means "newer than 7 days"
forfiles /P "%SOURCE_DIR%\files" /D -7 /C "cmd /c move @path %DEST_DIR%\files"

REM === Error Handling Example ===
REM Redirects errors to log file using 2>>
REM Checks errorlevel for operation status
echo Moving files with error checking
move "%SOURCE_DIR%\files\*.csv" "%DEST_DIR%\files" 2>>%LOGFILE%
if errorlevel 1 (
    echo Error occurred during file move >> %LOGFILE%
) else (
    echo Files moved successfully >> %LOGFILE%
)

REM === Completion and Summary ===
REM Display log contents and wait for user
echo Operations completed.
echo ========================
type %LOGFILE%
echo ========================

pause
endlocal