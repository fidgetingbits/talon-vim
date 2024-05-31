tag: user.vim_mason
-

mason show:
    user.vim_run_normal_exterm(":Mason\n")
mason log:
    user.vim_run_normal_exterm(":MasonLog\n")
mason install:
    user.vim_run_normal_exterm(":MasonInstall ")
mason uninstall:
    user.vim_run_normal_exterm(":MasonUninstall ")
mason uninstall all:
    user.vim_run_normal_exterm(":MasonUninstallAll")
