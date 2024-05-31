from talon import Context, Module, actions

mod = Module()
ctx = Context()

ctx.matches = """
tag: user.vim_taboo
"""


@ctx.action_class("user")
class user_actions:
    # FIXME: They should have some formatter probably
    def tab_rename(name):
        actions.user.vim_run_normal_exterm(f":TabooRename {name}")
