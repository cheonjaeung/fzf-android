# VHS Tape file to recort GIF of device serials example.

Output device-serials.gif

Set Shell "zsh"
Set FontSize 22
Set Width 1200
Set Height 600
Set Padding 20
Set Theme "Catppuccin Latte"

Hide
Type "source ./fzf-android.sh"
Enter
Type "stty -ixon"
Enter
Type "clear"
Enter
Show

Type "adb -s "
Sleep 500ms

Ctrl+A
Ctrl+S
Sleep 1s

Down
Sleep 500ms
Down
Sleep 500ms
Enter

Sleep 1s
Type "shell"
Sleep 500ms
Enter

Sleep 1s

Type "getprop ro.build.version.sdk"
Sleep 500ms
Enter

Sleep 2s

Type "exit"
Enter
Sleep 1s
