from talon import Module

mod = Module()
apps = mod.apps

apps.gdb = """
win.title: /TERM:gdb/
and win.title: /MODE:t/
"""

# NOTE: Double \\ to avoid re.error bad escape character \c
apps.cmd = """
win.title: /TERM:C:\\\\Windows\\\\system32\\\\cmd.exe/
"""

# FIXME: This is not generic as MINGW64 is a compiler, not actually git_bash specific
apps.git_bash = """
win.title: /TERM:MINGW64/
"""

apps.talon_repl = """
win.title: /TERM:Talon - REPL/
win.title: /TERM:~/.talon/bin/repl/
"""

# NOTE: Assumes something like: PS1="\[\e]0;${debian_chroot:+($debian_chroot)}wsl: \w\a\]$PS1"
apps.wsl = """
win.title: /TERM:wsl/
"""
