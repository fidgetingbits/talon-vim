win.title: /TERM:zsh/
-

# FIXME: Make the prompt line to search configurable
go last prompt:
    user.vim_any_motion_mode_exterm("0?❯ \n")
    insert("02l")

go next prompt:
    user.vim_any_motion_mode_exterm("0/❯ \n")
    insert("02l")
