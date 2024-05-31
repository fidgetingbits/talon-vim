# XXX this should only be enabled if were in a .ql file
# see also vim_codeql_panel.talon
tag: user.vim_codeql
-

query set database:
    user.vim_run_command(":SetDatabase ")
query set last database:
    user.vim_run_command(":SetDatabase ")
    key(up enter)
query unset database:
    user.vim_run_command(":UnsetDatabase ")
query run:
    user.vim_run_command(":RunQuery\n")
query quick eval:
    user.vim_run_command(":QuickEval\n")
# this is still load previous results
query history:
    user.vim_run_command(":History\n")
query stop history:
    user.vim_run_command(":StopServer\n")
query syntax tree:
    user.vim_run_command(":PrintAST\n")
query load serif:
    user.vim_run_command(":LoadSarif")
# This shows the database bar
query archive tree:
    user.vim_run_command(":ArchiveTree\n")
