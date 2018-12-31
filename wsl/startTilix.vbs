args = "-c" & " -l " & """DISPLAY=:0 tilix -e tmux"""
WScript.CreateObject("Shell.Application").ShellExecute "bash", args, "", "open", 0