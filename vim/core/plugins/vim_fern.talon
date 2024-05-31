# https://github.com/lambdalisue/fern.vim
# vim_fern_open.talon for the remainder of commands
# TODO - add clipboard for paths
tag: user.vim_fern
-

fern open:
    user.vim_run_normal_exterm(":Fern .\n")
fern bar:
    user.vim_run_normal_exterm(":Fern . -drawer\n")
