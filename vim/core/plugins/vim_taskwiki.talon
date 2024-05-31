# XXX - detect were actually specifically in something with a task before
tag: user.vim_taskwiki
and code.language: markdown
-

task (annotate | meta):
    user.vim_run_command(":TaskWikiAnnotate\n")
task burn [down] daily:
    user.vim_run_command(":TaskWikiBurndownDaily\n")
task burn [down] weekly:
    user.vim_run_command(":TaskWikiBurndownWeekly\n")
task burn [down] monthly:
    user.vim_run_command(":TaskWikiBurndownMonthly\n")

# Interactive
task choose project:
    user.vim_run_command(":TaskWikiChooseProject\n")
task choose tag:
    user.vim_run_command(":TaskWikiChooseTag\n")

task calendar:
    user.vim_run_command(":TaskWikiCalendar\n")
task done:
    user.vim_run_command(":TaskWikiDone\n")
task delete:
    user.vim_run_command(":TaskWikiDelete\n")
task edit:
    user.vim_run_command(":TaskWikiEdit\n")
task grid:
    user.vim_run_command(":TaskWikiGrid\n")
task grid monthly:
    user.vim_run_command(":TaskWikiGhistoryMonthly\n")
task great yearly:
    user.vim_run_command(":TaskWikiGhistoryAnnual\n")
task history:
    user.vim_run_command(":TaskWikiHistoryMonthly\n")
task history yearly:
    user.vim_run_command(":TaskWikiHistoryAnnual\n")
task info:
    user.vim_run_command(":TaskWikiInfo\n")
task link:
    user.vim_run_command(":TaskWikiLink\n")
task mod:
    user.vim_run_command(":TaskWikiMod\n")
task projects:
    user.vim_run_command(":TaskWikiProjects\n")
task summary:
    user.vim_run_command(":TaskWikiProjectsSummary\n")
task stats:
    user.vim_run_command(":TaskWikiStats")
task stats all:
    user.vim_run_command(":TaskWikiStats global\n")
task tags:
    user.vim_run_command(":TaskWikiTags\n")
task start:
    user.vim_run_command(":TaskWikiStart\n")
task stop:
    user.vim_run_command(":TaskWikiStop\n")

task (refresh | reload):
    user.vim_run_command(":TaskWikiBufferLoad\n")
task save:
    user.vim_run_command(":TaskWikiBufferSave\n")
task inspect:
    user.vim_run_command(":TaskWikiInspect\n")

# This is for undelete
task mark pending:
    user.vim_run_command(":TaskWikiMod\n")
    insert("status:pending\n")
