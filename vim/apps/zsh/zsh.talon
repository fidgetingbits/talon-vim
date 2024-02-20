win.title: /TERM:zsh/
-

# FIXME: This relies on the shell apps (gnome-terminal, kitty, etc) in talon having a "not vim" logic. Must be made
# generic somehow, so it doesn't need to be vim-aware...
tag(): terminal

# FIXME: Make the prompt line to search configurable
go last prompt:
    user.vim_any_motion_mode_exterm("0?❯ \n")
    insert("02l")

go next prompt:
    user.vim_any_motion_mode_exterm("0/❯ \n")
    insert("02l")
