# vim_nerdtree_open.talon for the remainder of commands
# https://github.com/preservim/nerdtree
tag: user.vim_nerdtree
-

nerd tree:
    user.vim_run_normal_exterm(":NERDTree\n")
nerd here:
    user.vim_run_normal_exterm(":NERDTree %\n")
nerd clip:
    user.vim_run_command_exterm(":NERDTree ")
    edit.paste()
    key(enter)
