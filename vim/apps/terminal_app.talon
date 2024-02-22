tag: user.vim_terminal_mode
tag: user.vim_normal_terminal_mode
-

go next prompt:
    prompt = user.get_terminal_application_prompt()
    #user.find_next_string(prompt)
    user.vim_any_motion_mode_exterm("0/{prompt}\n")
    insert("02l")

go last prompt:
    prompt = user.get_terminal_application_prompt()
    #user.find_previous_string(prompt)
    user.vim_any_motion_mode_exterm("0?{prompt}\n")
    insert("02l")
