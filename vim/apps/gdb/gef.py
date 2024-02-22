from talon import Context, Module

mod = Module()
ctx = Context()

# Should be tag: , not app:
ctx.matches = r"""
tag: user.gef
"""


@ctx.action_class("user")
class UserActions:
    def get_application_prompt():
        # FIXME: Not sure how to override this for gdb, so match both
        return "(gdb)\\|gef>"
