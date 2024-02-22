# This is a catch all for various shells that might be set in TERM:<shell> to
# set terminal mode. This is sometimes the case if you are in some sub-shell, etc
win.title: /TERM:bash/
win.title: /TERM:sh/
win.title: /TERM:zsh/
win.title: /TERM:fish/
-

# FIXME: This relies on the shell apps (gnome-terminal, kitty, etc) in talon having a "not vim" logic when deciding to
# enable terminal. Must be made
# generic somehow, so it doesn't need to be vim-aware...
tag(): terminal
