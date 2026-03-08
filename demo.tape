# VHS Tape file to record demo.gif

Output demo.gif

Set Shell "zsh"
Set FontSize 22
Set Width 1200
Set Height 600
Set Padding 20
Set Theme "Catppuccin Latte"

Hide
Type "source ./fzf-android.sh"
Enter
Type "export KEYTIMEOUT=2000"
Enter
Type "stty -ixon"
Enter
Type "clear"
Enter
Show

Type "emulator -avd "
Sleep 500ms
Ctrl+A
Ctrl+E
Sleep 1s

Down
Sleep 500ms
Enter

Sleep 500ms
Type "&"
Sleep 1s
Enter

Sleep 3s
Type "disown && clear"
Enter
Sleep 500ms

Type "adb -s "
Sleep 500ms
Ctrl+A
Ctrl+S
Sleep 1s

Down
Sleep 500ms
Enter
Sleep 1s

Type "install ~/Downloads/android-debug.apk"
Sleep 1s
Enter

Sleep 3s

Type "adb -s "
Sleep 500ms
Ctrl+A
Ctrl+S
Sleep 1s

Down
Sleep 500ms
Enter
Sleep 1s

Type "shell monkey -p com.cheonjaeung.compose.grid.sample.android 1"
Sleep 1s
Enter

Sleep 3s
