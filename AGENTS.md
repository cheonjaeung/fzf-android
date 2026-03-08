# Guidelines for AI Agents

## Core Rules

- All scripts and features MUST be compatible with both Bash and Zsh.
- Always verify the existence of required tools (e.g. `fzf` or `adb`) using `command -v` before executing core logic.
- When inserting selected items into the shell command line, always use shell-safe quoting (e.g., `(q)` for Zsh and `printf %q` for Bash) to prevent command injection or syntax errors.
- Handle key bindings (`bindkey` for Zsh, `bind` for Bash) and UI-related logic (like Zsh's `LBUFFER` or Bash's macro sequences) strictly within their respective shell-specific blocks.
- Redirect error messages to `stderr` (`>&2`) and ensure the script doesn't crash the user's current shell session on failure.

## Styles

- Write all code, comments, and documentation in English.
- Add documentation comments to all functions, explaining the purpose of the function and the specific shell behavior being targeted.
- Prefix internal utility functions with `__fza_` or `__fzf_android_` to avoid namespace collisions in the user's shell environment.
- Maintain a consistent `fzf` UI experience by using standard flags: `--height=40% --reverse`.
