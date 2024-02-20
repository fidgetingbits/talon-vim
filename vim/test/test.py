import tempfile
import time
from enum import Enum

from talon import Context, Module, actions, app, settings, ui

ctx = Context()

ctx.matches = r"""
app: vim
"""


class ActionType(Enum):
    COPY = 1
    BRING = 2


class TargetType(Enum):
    WORD = 1
    LINE = 2


mod = Module()
mod.setting(
    "talon_vim_enable_testing",
    type=bool,
    default=False,
    desc="Whether or not to enable the talon-vim test commands. (Development only)",
)

# FIXME: This could be brute forced at the beginning of testing
# See docs/TESTING.md for more information
mod.setting(
    "talon_vim_test_margin_lines",
    type=int,
    default=0,
    desc="The number of lines between echo output and the prompt where you enter new commands.",
)

vim_test_window_pid = None


def relative_line_number(number: int):
    """Get an adjusted spoken form of the wanted relative line number"""
    return actions.user.create_spoken_forms(
        f"{number + settings.get('user.talon_vim_test_margin_lines')}"
    )[0]


def terminal_mode_test(func):
    """Verify that we are still in vim and set known state"""

    def wrapper():
        global vim_test_window_pid
        if ui.active_window().app.pid != vim_test_window_pid:
            app.notify("talon-vim: Detecting window change. Aborting.")
            raise RuntimeError("Vim window has changed. Aborting test.")
        actions.user.vim_set_terminal_mode()

        if app.platform == "windows":
            # FIXME: This will depend on if it's cmd.exe?
            actions.insert("cls\n")
        else:
            actions.insert("clear\n")
        func()

    return wrapper


def assert_exact(result, expected):
    """Assert that the result is exactly what we expect

    Prints both g"""
    if result != expected:
        raise AssertionError(f"Expected '{expected}' but got '{result}'")


def get_mimiced_command_output(command, action: ActionType):
    """Mimic a talon command and fetch the results from the terminal window

    Depending on the action, we may need to paste the results"""
    with tempfile.NamedTemporaryFile() as temp:
        actions.insert("echo ")
        actions.mimic(command)
        match action:
            case ActionType.BRING:
                pass
            case ActionType.COPY:
                # FIXME: Windows?
                actions.edit.paste()
        actions.insert(f" > {temp.name}\n")
        time.sleep(0.5)
        print("Using temp file:", temp.name)
        contents = temp.read()
        temp.close()
    return contents.decode("utf-8").strip()


# FIXME: ActionType's are duplicated with saidelike code for now
# These should look up the associate spoken form from a user-specific list to match the grammar
spoken_action_names = {
    ActionType.BRING: "bring",
    ActionType.COPY: "yank",
}

spoken_target_names = {
    TargetType.LINE: "line",
    TargetType.WORD: "word",
}


def bring():
    """Returns the spoken from of the bring action"""
    return spoken_action_names[ActionType.BRING]


def copy():
    """Returns the spoken from of the copy action"""
    return spoken_action_names[ActionType.COPY]


def line():
    """Returns the spoken from of the line target"""
    return spoken_target_names[TargetType.LINE]


def word():
    """Returns the spoken from of the word target"""
    return spoken_target_names[TargetType.WORD]


@terminal_mode_test
def test_terminal_mode_bring_line_one():
    actions.insert("echo 'hello world!'\n")
    cmd = f"{bring()} {line()} {relative_line_number(1)}"
    result = get_mimiced_command_output(cmd, ActionType.BRING)
    assert_exact(result, "hello world!")
    print("test_terminal_mode_bring_line_one(): passed")


@terminal_mode_test
def test_terminal_mode_bring_line_two():
    actions.insert("echo 'hello world!\\ngoodbye world!'\n")
    cmd = f"{bring()} {line()} {relative_line_number(2)}"
    result = get_mimiced_command_output(cmd, ActionType.BRING)
    assert_exact(result, "hello world!")
    print("test_terminal_mode_bring_line_two(): passed")


@terminal_mode_test
def test_terminal_mode_copy_line_one():
    actions.insert("echo 'hello world!'\n")
    cmd = f"{copy()} {line()} {relative_line_number(1)}"
    result = get_mimiced_command_output(cmd, ActionType.COPY)
    assert_exact(result, "hello world!")
    print("test_terminal_mode_copy_line_one(): passed")


@terminal_mode_test
def test_terminal_mode_copy_line_two():
    actions.insert("echo 'hello world!\\ngoodbye world!'\n")
    cmd = f"{copy()} {line()} {relative_line_number(2)}"
    result = get_mimiced_command_output(cmd, ActionType.COPY)
    assert_exact(result, "hello world!")
    print("test_terminal_mode_copy_line_two(): passed")


@terminal_mode_test
def test_external_command_title_change():
    actions.insert("gdb\n")
    time.sleep(0.5)
    # We expect the title to change to "VIM MODE:t ... TERM:gdb
    if "TERM:gdb" not in ui.active_window().title:
        raise AssertionError("Title did not change as expected")
    # We need to quit out of gdb
    actions.insert("quit\n")
    print("test_external_command_title_change(): passed")


test_list = [
    test_terminal_mode_bring_line_one,
    test_terminal_mode_bring_line_two,
    test_terminal_mode_copy_line_one,
    test_terminal_mode_copy_line_two,
    test_external_command_title_change,
]


def start_vim_tests():
    app.notify(f'Starting {len(test_list)} tests. Say "stop vim tests" to abort.')
    global vim_test_window_pid
    vim_test_window_pid = ui.active_window().app.pid
    for test in test_list:
        test()


@mod.action_class
class Actions:
    def start_vim_tests():
        """Run the talon-vim tests"""
        if settings.get("user.talon_vim_enable_testing"):
            start_vim_tests()
        else:
            app.notify(
                "Vim testing disabled. Set user.talon_vim_enable_testing to enable."
            )

    def stop_vim_tests():
        """Stop the talon-vim tests"""
        global vim_test_window_pid
        if settings.get("user.talon_vim_enable_testing"):
            vim_test_window_pid = None
            app.notify("talon-vim tests stopped")
