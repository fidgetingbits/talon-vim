# See https://github.com/rhysd/vim-grammarous
tag: user.vim_grammarous
# by default this grammar file is using the calls to the <Plug> calls rather
# than using mappings, but this is very slow so it's recommended that you come
# up with your own mappings for all of the <Plug> calls and then call those
# mappings instead
-
grammar check:
    user.vim_run_command(":GrammarousCheck\n")

grammar help:
    user.vim_run_command(":GrammarousCheck --help\n")

grammar reset:
    user.vim_run_command(":GrammarousReset\n")

grammar fix:
    user.vim_run_command(':execute "normal \\<Plug>(grammarous-fixit)"\n')

grammar fix all:
    user.vim_run_command(':execute "normal \\<Plug>(grammarous-fixall)"\n')

grammar next:
    user.vim_run_command(':execute "normal \\<Plug>(grammarous-move-to-next-error)"\n')

grammar last:
    user.vim_run_command(':execute "normal \\<Plug>(grammarous-move-to-previous-error)"\n')

grammar disable:
    user.vim_run_command(':execute "normal \\<Plug>(grammarous-disable-rule)"\n')

grammar close:
    user.vim_run_command(':execute "normal \\<Plug>(grammarous-close-info-window)"\n')
