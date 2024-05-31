# https://github.com/numToStr/Comment.nvim
tag: user.vim_comment_nvim
-

# TODO: Move this to more explicit motion grammar, but at the moment I seem to have some
# problems with conflicts, so I'm explicitly doing it here.
[un] comment (toggle | this | line):
    user.vim_run_normal("gcc")
[un] comment <number_small> (line | lines):
    user.vim_run_normal("{number_small}gcc")
block comment (toggle | this):
    user.vim_run_normal("gbc")
[un] comment above:
    user.vim_run_normal_np("gcO")
[un] comment below:
    user.vim_run_normal_np("gco")
(comment push | push comment):
    user.vim_run_normal_np("gcA")

# TODO: This may differ in visual mode
# TODO: Technically the included text objects here are outside the scope of what can be done with
# commenting, but for the sake of not duplicating lists for now I will leave it here.
[un] comment (<user.vim_text_objects>):
    user.vim_run_normal("gc{vim_text_objects}")

[un] comment <number_small> (<user.vim_text_objects>):
    user.vim_run_normal("gc{number_small}{vim_text_objects}")

[un] comment till (<user.vim_motions>):
    user.vim_run_normal("gc{vim_motions}")
