tag: user.vim_trouble
and not win.title: /FILETYPE:\[Trouble\]/
-

trouble toggle:
    user.vim_run_command('exe ":TroubleToggle"\n')
trouble close:
    user.vim_run_command('exe ":TroubleClose"\n')
trouble refresh:
    user.vim_run_command('exe ":TroubleRefresh"\n')

trouble warn:
    user.vim_run_command(':exe ":Trouble document_diagnostics"\n')
trouble global warn:
    user.vim_run_command(':exe ":Trouble workspace_diagnostics"\n')
trouble (lock list | location):
    user.vim_run_command(':exe ":Trouble loclist"\n')
trouble ref:
    user.vim_run_command(':exe ":Trouble lsp_references"\n')
trouble quick:
    user.vim_run_command(':exe ":Trouble quickfix"\n')
trouble help:
    user.vim_run_command(":lua require('trouble').help()\n")
