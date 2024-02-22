from talon import Module

mod = Module()
apps = mod.apps

# FIXME: Instead of having /MODE:t/ in all of these, use a helper. We need to avoid MODE:nt because
# we don't want the specific app set for that mode, as it will enable a bunch of unwanted commands

apps.gdb = """
win.title: /TERM:gdb/
and win.title: /MODE:t/
"""

apps.zsh = """
win.title: /TERM:zsh/
and win.title: /MODE:t/
"""

apps.htop = """
win.title: /TERM:htop/
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
