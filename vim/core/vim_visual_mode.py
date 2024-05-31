import logging
import pprint

from talon import Context, Module, actions, clip

mod = Module()
mod.list("vim_visual_actions", desc="Vim visual mode actions")
mod.list(
    "vim_visual_counted_actions", desc="Vim visual mode actions that can be repeated"
)

ctx = Context()
ctx.matches = r"""
tag: user.vim_mode_visual
"""

# These override the ones in normal mode currently set in vim.py
ctx.lists["user.vim_visual_actions"] = {
    "yank": "y",
    "opposite": "o",
    "drop": "d",
}

ctx.lists["user.vim_visual_counted_actions"] = {
    "dedent": "<",
    "indent": ">",
}


@ctx.action_class("edit")
class EditActions:
    # when we're extending a selection in the opposite direction (backwards) we
    # need to a prefix an  beforehand so that it actually extends, rather than
    # changing directions.
    def extend_line_up():
        actions.insert("ok^o")

    def extend_line_down():
        actions.insert("j^")

    def extend_left():
        actions.insert("oho")

    def extend_right():
        actions.insert("l")

    def extend_word_left():
        actions.insert("obo")

    def extend_word_right():
        actions.insert("e")

    def select_word():
        actions.insert("e")

    def extend_line_start():
        actions.insert("o^o")

    def extend_line_end():
        actions.insert("$")

    def extend_file_start():
        actions.insert("ogg0o")

    def extend_file_end():
        actions.insert("G")
        # XXX - This should be a callable function so we can do things like:
        #       '.swap on this <highlight motion>'
        #       'swap between line x, y'
        # assumes visual mode

    def selected_text():
        # gv to reselect
        actions.insert("ygv")
        return clip.get()

    def indent_more():
        actions.insert(">")

    def indent_less():
        actions.insert("<")

    def delete_line():
        actions.insert("D")


@ctx.action_class("user")
class UserActions:
    def draft_app_submit(text: str):
        # Re-enter terminal mode
        actions.user.vim_set_terminal()
        actions.sleep("100ms")
        # actions.insert("i")
        actions.sleep("100ms")
        # Kill the existing command line
        actions.key("ctrl-a ctrl-k")
        # Re-insert the drafted text
        actions.user.paste(text)
