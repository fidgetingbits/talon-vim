tag: user.vim_lazy
win.title: /FILETYPE:\[lazy\]/
win.title: /FILETYPE:\[on\]/
-
# NOTE: I think the filetype 'on' above is probably a bug. It only triggers when lazy is
# called on initial startup

install:
    user.vim_run_normal("I")
update:
    user.vim_run_normal("U")
sync:
    user.vim_run_normal("S")
clean:
    user.vim_run_normal("X")
check:
    user.vim_run_normal("C")
log:
    user.vim_run_normal("L")
restore:
    user.vim_run_normal("R")
profile:
    user.vim_run_normal("P")
debug:
    user.vim_run_normal("D")
help:
    user.vim_run_normal("?")
close:
    user.vim_run_normal("q")
