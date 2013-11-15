@echo off
echo "Setting up Appbin: Wait for a while..."
start "Sync Daemon" /D "%APPDATA%\appbin\program_files\"  "%APPDATA%\appbin\program_files\appbin_daemon.exe"
