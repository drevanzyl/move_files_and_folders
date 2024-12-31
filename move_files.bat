REM filepath: /c:/Users/andre/Documents/Git/move_files_and_folders/move_files.bat
@echo off
setlocal EnableDelayedExpansion

REM Create log file with timestamp
set LOGFILE=move_files_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log

REM Set source and destination directories
set SOURCE_DIR=C:\Users\andre\Documents\Git\move_files_and_folders\source
set DEST_DIR=C:\Users\andre\Documents\Git\move_files_and_folders\destination

REM Check if directories exist
if not exist "%SOURCE_DIR%" (
    echo Error: Source directory does not exist >> %LOGFILE%
    exit /b 1
)
if not exist "%DEST_DIR%" (
    echo Creating destination directory
    mkdir "%DEST_DIR%"
)

REM Example of moving a specific file
echo Moving specific file
move "%SOURCE_DIR%\files\NWSS_Public_SARS-CoV-2_Wastewater_Metric_Data_20241231 - Copy.csv" "%DEST_DIR%\files"

REM Example of copying instead of moving files
echo Copying files from %SOURCE_DIR%\files to %DEST_DIR%\files
xcopy "%SOURCE_DIR%\files\*" "%DEST_DIR%\files\" /E /I /Y

REM Example of copying folders
echo Copying folders from %SOURCE_DIR%\folders to %DEST_DIR%\folders
xcopy "%SOURCE_DIR%\folders\*" "%DEST_DIR%\folders\" /E /I /Y

REM Move operations
REM Move files from source to destination
echo Moving files from %SOURCE_DIR%\files to %DEST_DIR%\files
move %SOURCE_DIR%\files\* %DEST_DIR%\files

REM Move folders from source to destination
echo Moving folders from %SOURCE_DIR%\folders to %DEST_DIR%\folders
for /D %%d in (%SOURCE_DIR%\folders\*) do (
    move "%%d" "%DEST_DIR%\folders"
)

REM Example of moving files by extension
echo Moving only CSV files
move "%SOURCE_DIR%\files\*.csv" "%DEST_DIR%\files"

REM Example of moving files newer than X days
forfiles /P "%SOURCE_DIR%\files" /D -7 /C "cmd /c move @path %DEST_DIR%\files"

REM Example of moving files with error handling
echo Moving files with error checking
move "%SOURCE_DIR%\files\*.csv" "%DEST_DIR%\files" 2>>%LOGFILE%
if errorlevel 1 (
    echo Error occurred during file move >> %LOGFILE%
) else (
    echo Files moved successfully >> %LOGFILE%
)

echo Operations completed.

REM Display operation summary
echo ========================
type %LOGFILE%
echo ========================

pause
endlocal