# https://github.com/gcmt/taboo.vim/
tag: user.vim_taboo
-

#tab rename:
#    user.vim_run_normal_exterm(":TabooRename ")
#tab rename <user.text>:
#    user.vim_run_normal_exterm(":TabooRename {text}")
new tab named:
    user.vim_run_normal_exterm(":TabooOpen ")
new tab named <user.text>:
    user.vim_run_normal_exterm(":TabooOpen {text}")
tab reset:
    user.vim_run_normal_exterm(":TabooReset\n")
