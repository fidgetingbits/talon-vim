app: gdb
not app: gdb
and tag: user.gdb
-

###
# VIM terminal GDB convenience
#
# These only work if you run GDB from inside a vim terminal and you're using
# vim.py automatic mode switching support
#
# It when you're running the terminal for a long time, the line numbers become
# so large they are hard to say, so I support some commands to use relative
# numbers. There is support in vim.talon for swapping between absolute and
# relative numbers relatively easily
###

## SAME LINE COMMANDS

# Assumes you are already on a line with hex addresses
copy <user.ordinals> (hex value | address):
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("{ordinals-1}n")
    insert("yw")
    user.vim_run_command(":set nohls\n")

# this has to be updated to use the new api
#(hexdump|matrix) <user.ordinals> (hex value|address):
#    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
#    insert("{ordinals-1}n")
#    insert("yw")
#    user.vim_run_command(":set nohls\n")
#    user.vim_set_insert()
#    # XXX - need to make this tweakable
#    insert("x/10gx ")
#    edit.paste()
#    key(enter)

go <user.ordinals> (hex value | address):
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("{ordinals-1}n")
    user.vim_run_command(":set nohls\n")

(hexdump | matrix) [this] address:
    insert("yiw")
    insert("i")
    insert("x/10gx ")
    edit.paste()
    key(enter)

### LINE JUMPING COMMANDS

# relative
copy line <number> (hex value | address):
    user.vim_run_normal_exterm("{number}k0")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    user.vim_run_normal("yw")
    user.vim_run_command(":set nohls\n")

# relative
# no arg, is just line above
bring hex:
    user.vim_run_normal_exterm("k0")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    user.vim_run_normal("yw")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    edit.paste()

# copy and paste the first hex value from the specified relative line
# relative
bring hex <number>:
    user.vim_run_normal_exterm("{number}k0")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    user.vim_run_normal("yw")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    edit.paste()

# copy and paste the Nth hex value from the specified relative line
# note for numbers like 70 actual individual digits really fast is more
# accurate
bring <user.ordinals> hex <number>$:
    user.vim_run_normal_exterm("{number}k0")
    # set the search pattern for 'n' usage
    insert("/\\c0x\n")
    key('0')
    # do the actual search to include results under the cursor
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("{ordinals-1}n")
    insert("ye")
    user.vim_run_command(":set nohls\n")

    user.vim_set_insert()
    edit.paste()

## absolute
(hexdump | matrix) line <number>$:
    user.vim_run_normal_exterm(":{number}\n")
    insert("^")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("yiw")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    # XXX - need to make this tweakable
    insert("x/100gx ")
    edit.paste()
    sleep(100ms)
    key(enter)

# relative
(hexdump | matrix) [relative] <number>$:
    user.vim_run_normal_exterm("{number+1}k")
    insert("^")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("yiw")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    # XXX - need to make this tweakable
    insert("x/100gx ")
    edit.paste()
    sleep(100ms)
    key(enter)

# relative
(hexdump | matrix) [relative] down [line] <number>$:
    user.vim_run_normal_exterm("{number+1}j")
    insert("^")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("yiw")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    # XXX - need to make this tweakable
    insert("x/100gx ")
    edit.paste()
    sleep(100ms)
    key(enter)

# absolute
(hexdump | matrix) line <number> <user.ordinals>$:
    user.vim_run_normal_exterm(":{number}\n")
    insert("^")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("{ordinals-1}n")
    insert("yw")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    # XXX - need to make this tweakable
    insert("x/100gx ")
    edit.paste()
    sleep(100ms)
    key(enter)

# relative
(hexdump | matrix) [relative] <user.ordinals> down [line] <number>$:
    user.vim_run_normal_exterm("{number+1}j")
    insert("^")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("yiw")
    insert("{ordinals-1}n")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    # XXX - need to make this tweakable
    insert("x/100gx ")
    edit.paste()
    sleep(100ms)
    key(enter)

# for use with relative number lines
(hexdump | matrix) [relative] <user.ordinals> up [line] <number>$:
    user.vim_run_normal_exterm("{number+1}k")
    insert("^")
    user.vim_run_command(":call search(\"0x\", 'c', line('.'))\n")
    insert("yiw")
    insert("{ordinals-1}n")
    user.vim_run_command(":set nohls\n")
    user.vim_set_insert()
    # XXX - need to make this tweakable
    insert("x/100gx ")
    edit.paste()
    sleep(100ms)
    key(enter)

# XXX - add something for highlighting and entire command that was just
# executed
