## Install & setup TPM (Tmux package manager)

1. install
    - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
2. add to `.tmux.conf`
```sh
set -g @plugin 'tmux-plugins/tpm'

run '~/.tmux/plugins/tpm/tpm'
```
3. run tmux session
4. check work & keybindings:
    - `prefix + U`: update plugins
    - `prefix + I`: install plugins
5. diagnostics:
    - `tail -f ~/.tmux/plugins/tpm/tpm.log`

## Setup saving sessions
> **_NOTE:_** I use `tmux-resurrect` for saving & restoring sessions.

1. add to `.tmux.conf`
```sh
# add session management
set -g @plugin 'tmux-plugins/tmux-resurrect'

# add continuum for automative saving session
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'
set -g @continuum-save-interval '5'  # autosave every 5 min

```
2. reload tmux and run `prefix + I`
3. keybings for manual saving:
    - save session: `prefix + Ctrl-s`
    - restore session: `prefix + Ctrl-r`
5. If you run tmux via alacritty like me, you can add to `alacrity.toml` next lines:
```toml
[terminal.shell]
args = ["-l", "-c", "tmux new -As alacritty"]
program = "/bin/zsh"

```
> **_NOTE:_** You can rely on autosave, but just in case you want to explicitly end the session, do a manual save.


