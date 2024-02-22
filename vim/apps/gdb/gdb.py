from talon import Context, Module

mod = Module()
ctx = Context()

# Should be tag: , not app:
ctx.matches = r"""
tag: user.gdb
"""


@ctx.action_class("user")
class UserActions:
    def get_terminal_application_prompt():
        return "(gdb)"
