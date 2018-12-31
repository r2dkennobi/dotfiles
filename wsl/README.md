# Setup notes

## Setup X11 for Windows
Install [VcXsrv](https://sourceforge.net/projects/vcxsrv/). Also fine with [Xming](https://sourceforge.net/projects/xming/).

Don't forget to lock down VcXsrv to localhost. Disable default firewall rules and create custom rules which only accept traffic from 127.0.0.1.

## Create a Windows shortcut to allow running Tilix and tmux directly
First, create a Visual Basic script to run Tilix and tmux:
```
args = "-c" & " -l " & """DISPLAY=:0 tilix -e tmux"""
WScript.CreateObject("Shell.Application").ShellExecute "bash", args, "", "open", 0
```

Then, create a Tilix shortcut with the following "Target" and "Start in" value:
```
Target: C:\Windows\System32\wscript.exe "C:\Users\Kenny\startTilix.vbs"
Start in: %USERPROFILE%
```

## WSL specific install list

```
dconf-editor
dbus-x11
```

## Troubleshooting
### dconf settings not getting set correctly
```
$ sudo apt-get install dconf-editor dbus-x11
```
