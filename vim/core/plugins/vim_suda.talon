# https://github.com/lambdalisue/suda.vim
tag: user.vim_suda
-

(sudo | suda) (read | edit):
    user.vim_run_command(":SudaRead ")
(sudo | suda) write:
    user.vim_run_command(":SudaWrite ")
