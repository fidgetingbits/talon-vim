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
