from talon import Context, actions

ctx = Context()
ctx.matches = r"""
tag: user.vim_mode_insert
"""


@ctx.action_class("edit")
class EditActions:
    def delete_line():
        actions.user.vim_run_normal("dd")
