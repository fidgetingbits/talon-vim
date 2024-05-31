tag: user.vim_mode_terminal
tag: user.vim_mode_normal_terminal
-

go next prompt:
    prompt = user.get_terminal_application_prompt()
    #user.find_next_string(prompt)
    user.vim_run_any_motion_exterm("0/{prompt}\n")
    insert("02l")

go last prompt:
    prompt = user.get_terminal_application_prompt()
    #user.find_previous_string(prompt)
    user.vim_run_any_motion_exterm("0?{prompt}\n")
    insert("02l")
