# fzf-android

Bash and Zsh key bindings for Android SDK CLI, inspired by [fzf-git](https://github.com/junegunn/fzf-git.sh).

![demo.gif](./vhs/demo.gif)

## Installation

This tool heavily depends on [fzf](https://github.com/junegunn/fzf) and Android SDK command line tools.
Check if the tools are installed in your environment.

### HomeBrew

1. Add Cheon Jaeung's Tap.

```sh
brew tap cheonjaeung/tap
```

2. Install fzf-android using brew.

```sh
brew install fzf-android
```

3. `source` the shell script to your `.bashrc` or `.zshrc`.

```sh
echo "source $(brew --prefix)/share/fzf-android/fzf-android.sh" >> ~/.zshrc
```

### Manual

1. Download or clone the project.

```sh
git clone https://github.com/cheonjaeung/fzf-android.git ~/.fzf-android
```

2. `source` the shell script to your `.bashrc` or `.zshrc`.

```sh
echo "source ~/.fzf-android/fzf-android.sh" >> ~/.zshrc
```

3. Restart your shell or apply the recent configuration.

```sh
source ~/.zshrc
```

## Usage

You can open the selector user interface using the following key bindings.

- <kbd>CTRL-A</kbd><kbd>?</kbd>: Show the help.
- <kbd>CTRL-A</kbd><kbd>CTRL-E</kbd>: Show the d**e**vice list.
- <kbd>CTRL-A</kbd><kbd>CTRL-V</kbd>: Show the android **v**irtual device list.
- <kbd>CTRL-A</kbd><kbd>CTRL-P</kbd>: Show the installed **p**ackage list.
- <kbd>CTRL-A</kbd><kbd>CTRL-F</kbd>: Show the device **f**ile list.

> [!TIP]
> You can use <kbd>CTRL-A</kbd><kbd>{key}</kbd> instead of <kbd>CTRL-A</kbd><kbd>CTRL-{key}</kbd>

## Examples

### Device Serials

Example of getting API level in the specific device's ADB shell.

![device-serials.gif](./vhs/device-serials.gif)

### Emulator

Example of starting a virtual device.

![emulator.gif](./vhs/emulator.gif)

## License

This project is licensed under the Apache License 2.0.

```
Copyright 2026 Cheon Jaeung

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
