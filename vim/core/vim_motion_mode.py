# This fowl contains editing actions that are only enabled in some sort of
# motion mode, so not including terminal or command line mode. To see the
# additional edit action overrides that are available in terminal, see
# vim_editing.py


from talon import Context, actions

ctx = Context()
ctx.matches = r"""
app:vim
not tag: user.vim_mode_terminal
and not tag: user.vim_mode_command
"""


@ctx.action_class("edit")
class EditActions:
    def save():
        actions.user.vim_run_command(":w\n")

    def find_next():
        actions.user.vim_run_any_motion_key("n")

    def word_left():
        actions.user.vim_run_any_motion_key("b")

    def word_right():
        actions.user.vim_run_any_motion_key("w")

    def line_start():
        actions.user.vim_run_any_motion_key("^")

    def line_end():
        actions.user.vim_run_any_motion_key("$")

    def file_end():
        actions.user.vim_run_any_motion_key("G")

    def file_start():
        actions.user.vim_run_any_motion("gg")

    def extend_line_up():
        actions.user.vim_run_visual("k^")

    def extend_line_down():
        actions.user.vim_run_visual("j^")

    def extend_left():
        actions.user.vim_run_visual("h")

    def extend_right():
        actions.user.vim_run_visual("l")

    def extend_word_left():
        actions.user.vim_run_visual("b")

    def extend_word_right():
        actions.user.vim_run_visual("e")

    def select_word():
        actions.user.vim_run_visual("e")

    def extend_line_start():
        actions.user.vim_run_visual("^")

    def extend_line_end():
        actions.user.vim_run_visual("$")

    def extend_file_start():
        actions.user.vim_run_visual("gg0")

    def extend_file_end():
        actions.user.vim_run_visual("G")

    def select_line(n: int = None):
        actions.user.vim_run_visual("V")

    def select_all():
        actions.user.vim_run_normal("ggVG")
        # See vim_normal.talon and vim_visual.talon for edit.extend_ commands

    def delete_word():
        actions.user.vim_run_normal("dw")

    def delete():
        actions.user.vim_run_insert_key("backspace")

    def redo():
        actions.user.vim_run_normal_key("ctrl-r")

    def undo():
        actions.user.vim_run_normal_key("u")

    # Note following two are for mouse/highlighted copy/paste. shouldn't be
    # used for actual vim commands

    def copy():
        actions.key("ctrl-shift-c")

    def paste():
        # actions.user.vim_run_normal("p")
        actions.key("ctrl-shift-v")
        # NOTE: There is it delay that happens inside of vim that can cause out
        # of order key pressing, in it seems to be that it's because the output
        # of this key press actually happens after other key presses start
        # getting interpreted? in example would be "sit graves pasty round".
        # typically the output of this will be something like:
        # `(<pasted content>)`
        # but the intended output would be
        # `<pasted content>()`
        # for now the only way i see to fix this is to introduce an artificial
        # delay to allow vim to actually paste the content...
        # time.sleep(0.800)
        #  XXX - This might be one solution for it, but i haven't got it to
        #  work yet
        # actions.user.vim_run_normal('"+p')


@ctx.action_class("user")
class UserActions:
    def delete_word_right():
        actions.user.vim_run_normal("dw")

    def delete_word_left():
        actions.user.vim_run_normal("db")

    def delete_line_remaining():
        actions.user.vim_run_normal("d$")

    def delete_line_beginning():
        actions.user.vim_run_normal("d0")

    def line_find_forward(key: str):
        # print(key)
        actions.user.vim_run_any_motion(f"f{key}")

    def line_find_backward(key: str):
        actions.user.vim_run_any_motion(f"F{key}")
