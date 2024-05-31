tag: user.vim_ultisnips
-
tag(): user.snippets
snippets refresh:
    user.vim_run_command_exterm(":call UltiSnips#RefreshSnippets()\n")
snippets add:
    user.vim_run_command_exterm(":UltiSnipsAddFiletypes \n")
#snippets show all: user.vim_run_command_exterm(":call UltiSnips#SnippetsInCurrentScope()\n")
#show all file snippets: user.vim_run_command_exterm(":call UltiSnips#SnippetsInCurrentScope(1)\n")
#snip next: key(ctrl-j)
#snip last: key(ctrl-k)
