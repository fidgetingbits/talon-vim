# https://github.com/tpope/vim-fugitive
# This file is specifically for when navigating the git-summary feature of the
# vim-fugitive plugin
# It currently relies on you using ${FugitiveStatusLine()} in your titlestring
# ex: let &titlestring ='VIM MODE:%{mode()} RPC:%{v:servername} %{FugitiveStatusline()} (%f) %t'
tag: user.vim_fugitive_summary
and win.title: /\[Git.*git.*index/
tag: user.vim_fugitive_summary
and win.title: /fugitive:\/\//
#tag: user.vim_fugitive_summary
#and win.title: /.git\/index/
-

# Staging/unstaging maps

[file] stage:
    user.vim_run_normal_key("s")
[file] unstage:
    user.vim_run_normal_key("u")
unstage (all | everything):
    user.vim_run_normal_key("U")
[file] discard change:
    user.vim_run_normal_key("X")
file diff:
    user.vim_run_normal_key("=")
file diff top:
    user.vim_run_normal("zt")
    user.vim_run_normal_key("=")
file exclude:
    user.vim_run_normal_keys("g I")

# Diff maps

# Navigation maps
# XXX - these should may be override common file actions
file open:
    user.vim_run_normal_key("o")
file open vertical:
    user.vim_run_normal_keys("g O")
file open tabbed:
    user.vim_run_normal_key("O")
file preview:
    user.vim_run_normal_key("p")

# Commit maps

git commit [changes]:
    user.vim_run_normal_keys("c c")
    user.vim_set_insert()
(fugitive | git) commit [message] {user.git_conventional_commits}:
    user.vim_run_normal_keys("c c")
    user.vim_set_insert()
    sleep(0.1)
    insert("{user.git_conventional_commits}: ")
(fugitive | git) commit [message] {user.git_conventional_commits} <user.word>:
    user.vim_run_normal_keys("c c")
    user.vim_set_insert()
    sleep(0.1)
    insert("{user.git_conventional_commits}({word}): ")
git commit verbose [changes]:
    user.vim_run_normal_keys("c v c")
    user.vim_set_insert()
(fugitive | git) commit verbose {user.git_conventional_commits}:
    user.vim_run_normal_keys("c v c")
    user.vim_set_insert()
    sleep(0.1)
    insert("{user.git_conventional_commits}: ")
(fugitive | git) commit verbose {user.git_conventional_commits} <user.word>:
    user.vim_run_normal_keys("c v c")
    user.vim_set_insert()
    sleep(0.1)
    insert("{user.git_conventional_commits}({word}): ")
amend [last commit]:
    user.vim_run_normal_keys("c v a")
commit reword:
    user.vim_run_normal("cw")

file restore:
    user.vim_run_normal_key("X")

# Checkout/branch maps

# Stash maps

# Rebase maps

git rebase start:
    user.vim_run_normal("ri")
git rebase continue:
    user.vim_run_normal("rr")
git rebase abort:
    user.vim_run_normal("ra")

# Miscellaneous maps

[git] status close:
    user.vim_run_normal_keys("g q")
(fugitive | git) help:
    user.vim_run_normal_keys("g ?")

# Navigation
jump untracked [<number>]:
    user.vim_run_normal("gu")
jump unstaged [<number>]:
    user.vim_run_normal("gU")
jump unpushed [<number>]:
    user.vim_run_normal("gp")
jump unpulled [<number>]:
    user.vim_run_normal("gP")

# Global maps
git status close:
    user.vim_run_normal("gq")
