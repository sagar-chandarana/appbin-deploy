
Set objShell = WScript.CreateObject("WScript.Shell")
Set lnk = objShell.CreateShortcut( WScript.Arguments(2))

lnk.TargetPath = "%appdata%\appbin\program_files\appbin_nw.exe"
lnk.Arguments = "launchernw " & WScript.Arguments(1) & " --data-path=" & Chr(34) & "%appdata%\appbin\data\default" & Chr(34)
lnk.Description = WScript.Arguments(3)
lnk.IconLocation = "%appdata%\appbin\program_files\apps\"& WScript.Arguments(0) & "\"& WScript.Arguments(0) & "\icon.ico"
lnk.WorkingDirectory = "%appdata%\appbin\program_files"
lnk.WindowStyle = "1"
lnk.Save


'Clean up ana
Set lnk = Nothing
   
	
