tag: user.vim_mode_normal
-

(shift | indent) right:
    insert(">>")
(shift | indent) left:
    insert("<<")

(dup | duplicate) line:
    insert("yy")
    insert("p")

yank line:
    insert("yy")

push:
    user.vim_run_normal_np("$a")

# NOTE - We need a separate key() call because some unmodified keys have
# special names, like backspace.
push <user.unmodified_key>:
    user.vim_run_normal_np("$a")
    key('{unmodified_key}')

# paste to the end of a line
# XXX
push it:
    user.vim_run_normal_np("A ")
    key(escape p)
