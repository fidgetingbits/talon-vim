tag: user.vim_mason
win.title: /FILETYPE:\[mason\]/
-

# There's a weird case where sometimes when I enter of floating window I'm actually in
# insert mode, , even though you can't directly enter insert mode. I guess this is
# because of the way I trigger certain commands using pynvim. So to work around this I
# still force all of these to use normal mode.

all:
    user.vim_run_normal("1")
L S P:
    user.vim_run_normal("2")
dap:
    user.vim_run_normal("3")
linter:
    user.vim_run_normal("4")
formatter:
    user.vim_run_normal("5")
install:
    user.vim_run_normal("i")
uninstall:
    user.vim_run_normal("X")
update:
    user.vim_run_normal("u")
update all:
    user.vim_run_normal("U")
check new:
    user.vim_run_normal("c")
check new all:
    user.vim_run_normal("C")
[mason] help:
    user.vim_run_normal("g?")
[mason] close:
    user.vim_run_normal("q")
