# Copyright 2026 Cheon Jaeung
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# fzf-android.sh
# Bash and Zsh key bindings for Android SDK CLI tools powered by fzf.

# Check the current shell is Zsh.
__fzf_android_is_zsh() {
  [[ -n "${ZSH_VERSION:-}" ]]
}

# Core function to display key bindings.
__fza_help() {
  echo
  cat <<'EOF'
fzf-android key bindings:
  CTRL-A ?     : Print this help
  CTRL-A CTRL-E: List emulators (AVDs)
  CTRL-A CTRL-S: List device serials
  CTRL-A CTRL-P: List installed packages
  CTRL-A CTRL-F: List files
EOF
}

# Core function to list android virtual devices and pick one using fzf.
__fza_avds() {
  # Check if the 'emulator' command exists in the system PATH.
  if ! command -v emulator > /dev/null; then
    echo "emulator command not found" >&2
    return 1
  fi

  emulator -list-avds | fzf --prompt="AVDs> " --height=40% --reverse
}

# Core function to list connected adb device serials and pick one using fzf.
__fza_adb_device_serials() {
  # Check if the 'adb' command exists in the system PATH.
  if ! command -v adb > /dev/null; then
    echo "adb command not found" >&2
    return 1
  fi

  adb devices | tail -n +2 | awk 'NF {print $1}' | fzf --prompt="ADB Device Serials> " --height=40% --reverse
}

# Core function to list installed packages and pick one using fzf.
__fza_pm_packages() {
  # Check if the 'adb' command exists in the system PATH.
  if ! command -v adb > /dev/null; then
    echo "adb command not found" >&2
    return 1
  fi

  # 'adb shell pm list packages' outputs lines like 'package:com.example.app\r'.
  # We use sed to remove the 'package:' prefix and the trailing carriage return (\r).
  adb shell pm list packages | sed $'s/^package://;s/\r$//' | fzf --prompt="Packages> " --height=40% --reverse
}

# Core function to list files in /sdcard and pick one using fzf.
__fza_adb_files() {
  # Check if the 'adb' command exists in the system PATH.
  if ! command -v adb > /dev/null; then
    echo "adb command not found" >&2
    return 1
  fi

  adb shell "find /sdcard/ -type f -not -path '*/.*' 2>/dev/null" | sed $'s/\r$//' | fzf --prompt="ADB Files> " --height=40% --reverse
}

if __fzf_android_is_zsh; then
  # Zsh-specific implementation

  # Join multiple lines into a single line with shell-safe quoting.
  __fzf_android_join() {
    local item
    while read item; do
      echo -n "${(q)item} "
    done
  }

  # ZLE (Zsh Line Editor) widgets.
  fza-help-widget() {
    __fza_help
    zle reset-prompt
  }

  fza-avds-widget() {
    # Get the selected AVD and format it.
    local result=$(__fza_avds | __fzf_android_join)
    # Clear the fzf UI from the screen.
    zle reset-prompt
    if [[ -n "$result" ]]; then
      # Append the selected value to the current command buffer.
      LBUFFER+=$result
    fi
  }

  fza-adb-device-serials-widget() {
    # Get the selected device serial and format it.
    local result=$(__fza_adb_device_serials | __fzf_android_join)
    # Clear the fzf UI from the screen.
    zle reset-prompt
    if [[ -n "$result" ]]; then
      # Append the selected value to the current command buffer.
      LBUFFER+=$result
    fi
  }

  fza-pm-packages-widget() {
    # Get the selected package name and format it.
    local result=$(__fza_pm_packages | __fzf_android_join)
    # Clear the fzf UI from the screen.
    zle reset-prompt
    if [[ -n "$result" ]]; then
      # Append the selected value to the current command buffer.
      LBUFFER+=$result
    fi
  }

  fza-adb-files-widget() {
    # Get the selected file path and format it.
    local result=$(__fza_adb_files | __fzf_android_join)
    # Clear the fzf UI from the screen.
    zle reset-prompt
    if [[ -n "$result" ]]; then
      # Append the selected value to the current command buffer.
      LBUFFER+=$result
    fi
  }
  # End of ZLE widgets.

  # Register the functions as a ZLE widget.
  zle -N fza-help-widget
  zle -N fza-avds-widget
  zle -N fza-adb-device-serials-widget
  zle -N fza-pm-packages-widget
  zle -N fza-adb-files-widget

  # Bind keys to the widget.
  bindkey '^a?' fza-help-widget # CTRL-A ?
  bindkey '^a^e' fza-avds-widget # CTRL-A CTRL-E
  bindkey '^a^s' fza-adb-device-serials-widget # CTRL-A CTRL-S
  bindkey '^a^p' fza-pm-packages-widget # CTRL-A CTRL-P
  bindkey '^a^f' fza-adb-files-widget # CTRL-A CTRL-F

else
  # Bash-specific implementation

  # Join lines with shell-safe quoting using printf.
  __fzf_android_join() {
    local item
    while read item; do
      printf '%q ' "$item"
    done
  }

  # Helper functions for Bash key binding.
  __fza_help_bash() {
    __fza_help
  }

  __fza_avds_bash() {
    local selected=$(__fza_avds | __fzf_android_join)
    if [[ -n "$selected" ]]; then
      READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
      READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
    fi
  }

  __fza_adb_device_serials_bash() {
    local selected=$(__fza_adb_device_serials | __fzf_android_join)
    if [[ -n "$selected" ]]; then
      READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
      READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
    fi
  }

  __fza_pm_packages_bash() {
    local selected=$(__fza_pm_packages | __fzf_android_join)
    if [[ -n "$selected" ]]; then
      READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
      READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
    fi
  }

  __fza_adb_files_bash() {
    local selected=$(__fza_adb_files | __fzf_android_join)
    if [[ -n "$selected" ]]; then
      READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
      READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
    fi
  }
  # End of helper functions.

  # Bind keys to the bash functions.
  bind -x '"\C-a?": __fza_help_bash'
  bind -x '"\C-a\C-e": __fza_avds_bash'
  bind -x '"\C-a\C-s": __fza_adb_device_serials_bash'
  bind -x '"\C-a\C-p": __fza_pm_packages_bash'
  bind -x '"\C-a\C-f": __fza_adb_files_bash'
fi
