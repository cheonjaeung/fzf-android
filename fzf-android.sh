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

# Core function to list android virtual devices and pick one using fzf.
__fza_avds() {
  # Check if the 'emulator' command exists in the system PATH.
  if ! command -v emulator > /dev/null; then
    echo "emulator command not found" >&2
    return 1
  fi

  emulator -list-avds | fzf --prompt="AVDs> " --height=40% --reverse
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

  # ZLE (Zsh Line Editor) widget.
  # This function is triggered by the key binding.
  fza-avds-widget() {
    # Get the selected AVD and format it.
    local result=$(__fza_avds | __fzf_android_join)
    # Clear the fzf UI from the screen.
    zle reset-prompt
    # Append the selected value to the current command buffer.
    LBUFFER+=$result
  }
  # Register the function as a ZLE widget.
  zle -N fza-avds-widget
  # Bind CTRL-A CTRL-E to the widget.
  bindkey '^a^e' fza-avds-widget

else
  # Bash-specific implementation

  # Join lines with shell-safe quoting using printf.
  __fzf_android_join() {
    local item
    while read item; do
      printf '%q ' "$item"
    done
  }

  # Helper function for Bash key binding.
  __fza_avds_bash() {
    __fza_avds | __fzf_android_join
  }

  # Bash key bindings are more complex.
  # This sequence saves the current line, executes the helper function to get the selection,
  # and restores the line with the selection inserted.
  bind -m emacs-standard '"\er": redraw-current-line'
  bind -m emacs-standard '"\C-a\C-e": " \C-e\C-u\C-y\ey\C-u`__fza_avds_bash`\e\C-e\er\C-m\C-y\ey\C-u\C-y\ey\C-u"'
  # Bindings for VI mode if enabled.
  bind -m vi-command '"\C-a\C-e": "\C-z\C-a\C-e"'
  bind -m vi-insert '"\C-a\C-e": "\C-z\C-a\C-e"'
fi
