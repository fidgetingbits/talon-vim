tag: user.vim_copilot
-

copilot disable:
    user.vim_run_command(":Copilot disable\n")
copilot enable:
    user.vim_run_command(":Copilot enable\n")
copilot status:
    user.vim_run_command(":Copilot status\n")
copilot panel:
    user.vim_run_command(":Copilot panel\n")
copilot version:
    user.vim_run_command(":Copilot version\n")
copilot suggest:
    user.vim_run_command(':execute "normal \\<Plug>(copilot-suggest)"\n')
copilot dismiss:
    user.vim_run_command(':execute "normal \\<Plug>(copilot-dismiss)"\n')
copilot next:
    user.vim_run_command(':execute "normal \\<Plug>(copilot-next)"\n')
copilot (last | previous | prev):
    user.vim_run_command(':execute "normal \\<Plug>(copilot-previous)"\n')
# purposefully don't have new lines at the end of these commands
copilot setup:
    user.vim_run_command(":Copilot setup")
copilot sign out:
    user.vim_run_command(":Copilot signout")
