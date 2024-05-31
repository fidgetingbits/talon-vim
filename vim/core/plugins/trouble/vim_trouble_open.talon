tag: user.vim_trouble
win.title: /FILETYPE:\[Trouble\]/
-

# TODO: It might be good to remove some of the other default of in bindings here?
# This list is also incomplete, see: https://github.com/folke/trouble.nvim#setup
[trouble] close:
    user.vim_run_normal("q")
[trouble] refresh:
    user.vim_run_normal("r")
[trouble] next:
    user.vim_run_normal("j")
[trouble] previous:
    user.vim_run_normal("k")
[trouble] jump:
    user.vim_run_normal("enter")
[trouble] jump close:
    user.vim_run_normal("o")
[trouble] hover:
    user.vim_run_normal("K")
