from talon import Context, actions

ctx = Context()
ctx.matches = r"""
tag: user.vim_mode_normal
"""


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
