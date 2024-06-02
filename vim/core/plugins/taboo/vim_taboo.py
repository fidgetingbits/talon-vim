from talon import Context, actions

ctx = Context()

ctx.matches = """
tag: user.vim_taboo
"""


@ctx.action_class("user")
class user_actions:
    def tab_rename(name):
        actions.user.vim_normal_mode_exterm(f":TabooRename {name}")
