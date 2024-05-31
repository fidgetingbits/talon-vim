tag: user.vim_test
# TODO - should only be activated when you're using a language with tests...
-

test nearest:
    user.vim_run_command(":TestNearest")
test file:
    user.vim_run_command(":TestFile")
test suite:
    user.vim_run_command(":TestSuite")
test last:
    user.vim_run_command(":TestLast")
test visit:
    user.vim_run_command(":TestVisit")
