tag: user.vim_fzf
-

# ripgrep through files under current directory
hunt code:
    user.vim_run_command_exterm(':exe ":Rg"\n')
hunt code clip:
    user.vim_run_command_exterm(':exe ":Rg"\n')
    edit.paste()
# XXX - this should behave differently depending on if it's a selection in
# visual mode, etc
hunt code this:
    user.vim_run_normal("yiw")
    user.vim_run_command_exterm(':exe ":Rg"\n')
    edit.paste()

fuzz buffer commits:
    user.vim_run_command_exterm(':exe ":BCommit"\n')

# Lines across current buffer
hunt lines:
    user.vim_run_command_exterm(':exe ":BLines"\n')

hunt tags:
    user.vim_run_command_exterm(':exe ":BTags"\n')

# Open buffers
hunt buffers:
    user.vim_run_command_exterm(':exe ":Buffers"\n')

fuzz code search:
    user.vim_run_command_exterm(':exe ":Ag"\n')
fuzz colors:
    user.vim_run_command_exterm(':exe ":Colors"\n')
hunt command history:
    user.vim_run_command_exterm(':exe ":History:"\n')
hunt commands:
    user.vim_run_command_exterm(':exe ":Commands"\n')
hunt commits:
    user.vim_run_command_exterm(':exe ":Commit"\n')
fuzz file types:
    user.vim_run_command_exterm(':exe ":Filetypes"\n')

# Files under current directory

hunt (file | files):
    user.vim_run_command_exterm(':exe ":Files"\n')
hunt (file | files) <user.text>:
    user.vim_run_command_exterm(':exe ":Files"\n')
    insert(text)

fuzz git files:
    user.vim_run_command_exterm(':exe ":GFiles"\n')
fuzz git status:
    user.vim_run_command_exterm(':exe ":GFiles?"\n')
fuzz help tags:
    user.vim_run_command_exterm(':exe ":Helptags"\n')
fuzz history:
    user.vim_run_command_exterm(':exe ":History"\n')

# Lines across all open buffers
hunt all lines:
    user.vim_run_command_exterm(':exe ":Lines"\n')
fuzz locate:
    user.vim_run_command_exterm(":Locate ")
fuzz maps:
    user.vim_run_command_exterm(':exe ":Maps"\n')
hunt marks:
    user.vim_run_command_exterm(':exe ":Marks"\n')
fuzz search history:
    user.vim_run_command_exterm(':exe ":History/"\n')
hunt snippets:
    user.vim_run_command_exterm(':exe ":Snippets"\n')
fuzz tags:
    user.vim_run_command_exterm(':exe ":Tags"\n')
hunt windows:
    user.vim_run_command_exterm(':exe ":Windows"\n')
