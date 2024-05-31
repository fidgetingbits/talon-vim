tag: user.vim_plug
-

plugins install:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugInstall\n")
plugins force install:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugInstall!\n")
plugins status:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugStatus\n")
plugins clean:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugClean\n")
plugins diff:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugDiff\n")
plugins update:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugUpdate\n")
plugins force update:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugUpdate!\n")
plugins upgrade:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugUpgrade\n")
plugins snapshot:
    user.vim_run_normal_exterm(":so $MYVIMRC\n")
    user.vim_run_normal_exterm(":PlugSnapshot\n")
