from talon import Context, Module

mod = Module()
ctx = Context()

# Should be tag: , not app:
ctx.matches = r"""
tag: user.zsh
"""


@ctx.action_class("user")
class UserActions:
    def get_terminal_application_prompt():
        # FIXME: This should become configurable elsewhere probably with a generic prompt setting,
        # and use a settings query
        return "❯ "
