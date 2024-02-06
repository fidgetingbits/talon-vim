tag: user.vim_test
# TODO - should only be activated when you're using a language with tests...
-

test nearest: user.vim_command_mode(":TestNearest")
test file: user.vim_command_mode(":TestFile")
test suite: user.vim_command_mode(":TestSuite")
test last: user.vim_command_mode(":TestLast")
test visit: user.vim_command_mode(":TestVisit")
