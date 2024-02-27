from talon import Context, Module

mod = Module()
ctx = Context()

# Should be tag: , not app:
ctx.matches = r"""
tag: user.pwndbg
"""


@ctx.action_class("user")
class UserActions:
    def get_terminal_application_prompt():
        # FIXME: Not sure how to override this for gdb, so match both
        return "(gdb)\\|pwndbg>"
