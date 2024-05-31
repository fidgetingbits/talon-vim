tag: user.vim_mkdx
-

# Navigation
jump [to] (anchor | heading):
    user.vim_run_command(":call mkdx#JumpToHeader()\n")
jump next header:
    user.vim_run_normal_keys("] ]")
jump (prev | previous) header:
    user.vim_run_normal_keys("[ [")
jump link:
    user.vim_run_normal_key("enter")
[markdown] quick talk:
    user.vim_run_command(":call mkdx#QuickfixHeaders()\n")

# TODO: Add jumping to next header, but see if there's a better way to do it with
# treesitter?
