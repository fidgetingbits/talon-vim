import re
import time
from timeit import default_timer as timer

from talon import Context, Module, actions, app, settings, ui

mod = Module()
ctx = Context()
ctx.matches = r"""
tag: user.vim_mode_terminal
"""

last_title = None
last_window = None


@ctx.action_class("edit")
class EditActions:
    def page_up():
        actions.key("ctrl-\\ ctrl-n ctrl-b")

    # XXX - this might be a bit much if eventually we want this to mean to let
    # everything on the command-line itself, although then we might be able to
    # just use things like select line/graph, etc
    def select_all():
        actions.user.vim_run_normal_exterm("ggVG")

    def select_line(n: int = None):
        if n is not None:
            app.notify(
                "vim_mode_terminal.py: select_line() with argument not implemented"
            )
            return
        actions.user.vim_run_normal_exterm("V")
        time.sleep(1)

    def paste():
        actions.key("ctrl-shift-v")


# @mod.action_class
# class Actions:
#     # FIXME: This needs to import VimMode() from vim.py I guess?
#     def vim_set_normal():
#         """set normal mode"""
#         v = VimMode()
#         v.set_normal_mode(auto=False)


def parse_vim_term_title(window):
    """a variety of parsing to gracefully handle various shell commands
    running inside of a vim terminal.
    :returns: TODO

    """
    global last_window
    global last_title
    # start = timer()

    current_title = window.title
    if last_window == window and last_title == current_title:
        # print("parse_vim_term_title(): Skipping due to duplicate title")
        # end = timer()

        #        print(start)
        #        print(end)
        # print(f"parse_vim_term_title - duplicate: {end - start}")
        return
    if (
        window != ui.active_window()
        or not current_title.startswith("VIM MODE:t")
        or "TERM:" not in current_title
    ):
        # print("parse_vim_term_title(): Skipping due to not a terminal")
        # end = timer()
        #        print(start)
        #        print(end)
        #        print(f"parse_vim_term_title - not vim: {end - start}")

        return

    last_window = window
    last_title = current_title

    # pull a TERM: line out of something potentially like
    # VIM MODE:t RPC:/tmp/nvimlVeccr/0  TERM:gdb (term://~//161917:/usr/bin/zsh) zsh
    index = current_title.find("TERM:")
    shell_command = current_title[index + len("TERM:") :]
    cwd = None
    if ":" in shell_command:
        # FIXME: This will break if there's a : or ( in the path
        cwd = shell_command.split(":")[1].split("(")[0]
        shell_command = shell_command.split(":")[0]
    if shell_command.startswith("sudo"):
        # Handle something like:
        # VIM MODE:t RPC:/tmp/nvimlVeccr/0  TERM:sudo gdb (term://~//161917:/usr/bin/zsh) zsh
        shell_command = shell_command.split(" ")[1]
    else:
        shell_command = shell_command.split(" ")[0]
    # end = timer()
    #    print(start)
    #    print(end)
    #    print(f"parse_vim_term_title - pass to populate: {end - start}")

    tags = populate_shell_tags(shell_command, window.title)
    # if tags is not None and "terminal" in tags:
    #     # Parse folder from the window title
    #     cwd = window.title.split("TERM:")[1].split(":")[1].split("(term")[0]

    populate_language_modes(shell_command)


language_specific_commands = {
    "repl": "python",
}


def populate_language_modes(shell_command):
    """Tries to enable language modes based off special cases of programs being
    run, for instance running debuggers to enable gdb language, or running
    repl to enable python language

    :shell_command: The shell command being run by the terminal
    """

    for command in language_specific_commands.keys():
        if shell_command.endswith(command):
            print("vim_terminal.py: setting context-specific language")
            actions.user.code_set_context_language(language_specific_commands[command])
            return

    # XXX - sometimes this throws an exception saying it's not declared, but it
    # should be a global module action from code.py
    # Why do I clear the context language if there's no match?
    # actions.user.code_clear_context_language()
    return


# XXX - there's probably a better way to deal with this
fuzzy_shell_tags = {
    # Match on stuff like fzf running in floating term
    # "term://": "user.readline",
    "root@": "terminal",  # hacky match for docker containers
    # "python:": "user.python", # Doesn't work because of the switch back to language modes
}
# XXX - should I pre compile these so we don't do it on every single window
# update?
regex_shell_tags = {
    r"^\w*@\w*": "terminal",
    # this is redundant with above, but ideally I would rather have something like this
    r"^\w*@\w*:.*[$#]": "terminal",
    ".*virsh start --console.*": "terminal",  # hacky match for libvirt containers
}

shell_tags = {
    # "zsh": "terminal",
    # "bash": "terminal",
    # "sh": "terminal",
    "ssh": "terminal",
    "sudo": "terminal",
    "edit": "terminal",  # This matches when edit is hung waiting for vscode
    # "gdb": "user.gdb",
    # "pwndbg": ["user.gdb", "user.pwndbg"],
    # "gef": ["user.gdb", "user.gef"],
    # "htop": "user.htop",
    "taskwarrior-tui": "user.taskwarrior_tui",
    "~/.talon/bin/repl": "user.talon_repl",
    # "~/.talon/bin/repl": ["user.talon_repl", "user.python"], # Doesn't work because of the switch back to language modes
    # "python": "user.python", # Doesn't work because of the switch back to language modes
}
# ...


def populate_shell_tags(shell_command, window_title):
    """TODO: Docstring for populate_shell_tags.
    :returns: TODO

    """

    tags = []
    if shell_command in shell_tags:
        # XXX - make a better way of marking stuff in noisy event log,
        # ins this writes to our file/terminal
        # actions.insert('marker start')
        # print(f"setting shell tags: {window_title}")
        # print(ctx.tags)
        if isinstance(shell_tags[shell_command], list):
            start = timer()
            tags = shell_tags[shell_command]
            ctx.tags = tags
        else:
            start = timer()
            tags = [shell_tags[shell_command]]
            ctx.tags = tags
        end = timer()
        # print(f"populate_shell_tags: {end - start}")

        # actions.insert('marker end')

        # print(f"populate_shell_tags(): set {ctx.tags}")
    else:
        # print(f"trying fuzzy: {window_title}")
        found_fuzzy = False
        for tag in fuzzy_shell_tags:
            # print(f"shell_command: {shell_command}")
            if shell_command.startswith(tag):
                # print("found python")
                tags = [fuzzy_shell_tags[tag]]
                ctx.tags = tags
                found_fuzzy = True
                break
        if found_fuzzy:
            return tags
        for expression in regex_shell_tags:
            m = re.match(expression, shell_command)
            if m is not None:
                tags = [regex_shell_tags[expression]]
                ctx.tags = tags
                break
            m = re.match(expression, window_title)
            if m is not None:
                tags = [regex_shell_tags[expression]]
                ctx.tags = tags
                break

    return tags


#        if not found_fuzzy:
#            print(f"WARNING: missing tag for shell cmd: {shell_command}")
#            print(f"WARNING: consider updating vim_terminal.py: {shell_command}")
#


def win_title_hook(window):
    parse_vim_term_title(window)


def win_focus_hook(window):
    parse_vim_term_title(window)


def register_events():
    ui.register("win_title", win_title_hook)
    ui.register("win_focus", win_focus_hook)


app.register("ready", register_events)


@mod.action_class
class Actions:
    def get_terminal_application_prompt() -> str:
        """Return the application prompt for a cli utility. Ex: (gdb)"""
