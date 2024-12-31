# File and Folder Movement Script

A batch script for automating file and folder operations between source and destination directories.

## Functionality

The `move_files.bat` script provides various file operation examples:

- Moving specific files
- Copying entire directories
- Moving files by extension (e.g., *.csv)
- Moving files newer than specific dates
- Error handling and logging

## Directory Structure

```
├── source/
│   ├── files/
│   └── folders/
└── destination/
    ├── files/
    └── folders/
```

## Key Features

- Creates timestamped log files
- Checks for directory existence
- Handles errors and provides feedback
- Supports both copy and move operations
- Filters files by date and extension

## XCOPY Parameters Used

- `/E` - Copies directories and subdirectories, including empty ones
- `/I` - Creates destination directory if it doesn't exist
- `/Y` - Suppresses prompting to confirm overwriting files

## Error Handling

The script includes:
- Directory existence validation
- Operation logging
- Error capture to log file
- Operation summary display

## Usage

1. Set your source and destination paths in the script
2. Run `move_files.bat`
3. Check the generated log file for operation details

## Requirements

- Windows operating system
- Administrative privileges (if working with protected directories)