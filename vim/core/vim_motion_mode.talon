# This file is for commands that should work in all motion modes (NORMAL,
# VISUAL, VBLOCK, INSERT) but it won't work for command or terminal mode. If
# you're not sure a command should be placed here it might be better to just
# put it in vim.talon, but mostly just ask yourself can you ever imagine being
# in command mode or inside of a terminal and wanting to run the command? If
# you can't imagine doing it, it suits this file over vim.talon
app: vim
not tag: user.vim_mode_terminal
and not tag: user.vim_mode_command
-

# Talon VIM plugin tags - see plugins/ for implementations
# Comment out plugins below that you don't use
# Is the list below is only plugins that have grammars we use when outside of
# terminal mode.
#tag(): user.vim_easymotion
# tag(): user.vim_leap
# tag(): user.vim_change_inside_surroundings
# tag(): user.vim_surround
#tag(): user.vim_ultisnips
# tag(): user.vim_ale
# tag(): user.vim_cscope
# tag(): user.vim_fugitive
# tag(): user.vim_fugitive_summary
# tag(): user.vim_grammarous
#tag(): user.vim_markdown
# tag(): user.vim_markdown_toc
#tag(): user.vim_youcompleteme
# tag(): user.vim_easy_align
# tag(): user.vim_eunuch
tag(): user.vim_rooter
tag(): user.vim_suda
# tag(): user.vim_treesitter
# tag(): user.vim_treesitter_textobjects
# tag(): user.vim_lsp
# tag(): user.vim_copilot
# tag(): user.vim_markdown_preview
# tag(): user.vim_comment_nvim
# tag(): user.vim_follows_md_links
# tag(): user.vim_trouble
# tag(): user.vim_null_ls
# tag(): user.vim_flip_ext

###
# `vim.py` and `vim_run_visual.py` actions - includes most motions and core commands
###
# See vim_insert_normal_mode.talon  and vim_run_visual.talon for motion commands
# NOTE: After about two years I got fed up of all of the misrecognitions for
# these, so I decided to prefix everything with go. You may want to change them
# if you don't have issues with lots of bad recognitions
go <user.vim_normal_counted_motion_keys>:
    user.vim_run_any_motion_key("{vim_normal_counted_motion_keys}")
go <user.vim_motions_all_adjust>:
    user.vim_run_any_motion("{vim_motions_all_adjust}")

###
# File editing and management
###
# These are prefix with `file` to match the `file save` action defined by talon
sage:
    user.vim_run_command(":w\n")
force sage:
    user.vim_run_command(":w!\n")
file save as:
    key(escape)
    user.vim_run_command(":w ")
# XXX - This should be vim_run_command, but there's a bug in at lest
# vim-fugitive commit where you lose the commit text if called from INSERT
# mode, due to an unmodifiable buffer error
(file save and (quit | close) | squeak):
    user.vim_run_normal(":wq\n")
file (close | quite):
    user.vim_run_command(":q\n")
file (refresh | reload):
    user.vim_run_command(":e!\n")
file show:
    user.vim_run_normal_keys("1 ctrl-g")
(print working directory | folder show):
    user.vim_run_command(":pwd\n")
pivot file:
    user.vim_run_command(":lcd %:p:h\n")
pivot clip:
    user.vim_run_command(":lcd ")
    edit.paste()
    key(enter)
#pivot (parent|back):
#    user.vim_run_command(":lcd ..\n")
pivot [select]:
    user.vim_run_command(":lcd ")
# Note below includes pivot back
pivot <user.folder_paths>:
    user.vim_run_command(":lcd {folder_paths}\n")
file yank path:
    user.vim_run_command(":let @+ = expand('%:p')\n")
file yank name:
    user.vim_run_command(":let @+ = expand('%:t')\n")
folder yank path:
    user.vim_run_command(":let @+ = expand('%:h')\n")
file recover:
    user.vim_run_command(":recover")

# For when the VIM cursor is hovering on a path
# NOTE: gx only works if you use netrw were custom mapped
#open [this] link: user.vim_run_normal("gx")
# XXX - this is broken if the link has some special characters like #, it will
# replace with the act of buffer name
open [this] link:
    user.vim_run_command(":!xdg-open ")
    key(ctrl-r ctrl-a enter)
(open this file | file jump):
    user.vim_run_normal("gf")
(open this file offset | file jump offset):
    user.vim_run_normal("gF")
# XXX - should automate this with the previous open for cases when a file
# doesn't exist...
file create this:
    user.vim_run_command(':call writefile([], expand("<cfile>"), "b")\n')
(river this [file] | file river jump):
    user.vim_set_normal()
    key(ctrl-w)
    key(f)
open this file in vertical [split | window]:
    user.vim_run_command(":vertical wincmd f\n")
(pillar this [file] | file pillar jump):
    user.vim_run_command(":vertical wincmd f\n")

###
# Navigation, movement and jumping
###

# XXX - add support for [{, [(, etc
matching:
    user.vim_run_any_motion_key("%")
matching <user.symbol_key>:
    user.vim_run_any_motion("f{symbol_key}%")

# ctags/symbol
jump tag:
    user.vim_run_normal_key("ctrl-]")
(jump | taggy) back:
    user.vim_run_normal_key("ctrl-t")
jump forward:
    user.vim_run_command(":tag\n")
jump tag (that | clip):
    user.vim_run_command(":tag ")
    edit.paste()
    key(enter)
jump (exact tag | tag exact):
    user.vim_run_command(":tag ")
jump exact (<user.format_text>+ | <user.word>)$:
    user.vim_run_command(":tag ")
    user.insert_many(format_text_list or word)

taggy list:
    user.vim_run_command(":tags\n")

###
# Text editing, copying, and manipulation
###

# indenting
indent [line] <number> through <number>$:
    user.vim_run_command(":{number_1},{number_2}>\n")
unindent [line] <number> through <number>$:
    user.vim_run_command(":{number_1},{number_2}>\n")

change remaining line:
    user.vim_run_normal_key("C")
change line:
    user.vim_run_normal("cc")
# XXX - technically these might be doable in command line mode, but life should
# become default talon and actions
# XXX - this might be suited for some automatic motion thing in vim.py
swap (bytes | char | characters):
    user.vim_run_normal("x")
    user.vim_run_normal("p")

# NOTE: this handles spaces
swap words:
    user.vim_run_normal("de")
    user.vim_run_normal('"_xw')
    user.vim_run_insert(" ")
    user.vim_run_normal("P")
swap lines:
    user.vim_run_normal("dd")
    user.vim_run_normal("p")
swap (paragraph | graph):
    user.vim_run_normal("d}}")
    user.vim_run_normal("p")
patch <user.unmodified_key>:
    user.vim_run_any_motion("r{unmodified_key}")
patch (ship | upper | upper case) <user.letters>:
    user.vim_run_any_motion_key("r")
    user.insert_formatted(letters, "ALL_CAPS")
# Delete the next in since of this specified character
shoot <user.unmodified_key>:
    user.vim_run_any_motion("f{unmodified_key}")
    user.vim_run_any_motion("x")

# deleting
(delete | trim) remaining [line]:
    user.vim_run_normal_key("D")
# XXX - these need to intelligently handle relative versus absolute numbering
clear line [at | number] <number>$:
    user.vim_run_command(":{number}d\n")
clear (line | lines) [at | number] <number> through <number>$:
    user.vim_run_command(":{number_1},{number_2}d\n")
clear (until | till) line <number>:
    user.vim_run_normal_np("m'")
    insert(":{number}\n")
    user.vim_set_visual_line()
    insert("''d")

# XXX - For stuff like this where we have multiple inputs in a motion mode but
# at the very end we want the preservation of the original mode, technically we
# could use a more complicated function that takes a variable list of
# arguments, and detects that this is happening doesn't bother keep switching
# the mode until the very last one
wipe line:
    # Purposely two calls for insert preservation
    user.vim_run_normal("0")
    user.vim_run_normal("d$")

# delete a line without clobbering the paste register
# XXX - this should become a general yank, delete, etc command prefix imo
forget line:
    user.vim_run_normal('"_dd')

# copying
yank line <number>$:
    user.vim_run_command_exterm(":{number}y\n")
(copy | yank) <number_small> lines at line <number>$:
    user.vim_run_command_exterm(":{number}\n")
    user.vim_run_normal_exterm("y{number_small}y")
(copy | yank) line (at | number) <number> through <number>:
    user.vim_run_command_exterm(":{number_1},{number_2}y\n")
    user.vim_run_command(":{number_1},{number_2}y\n")
    user.vim_run_command("p")

(copy | yank) line relative up <number>:
    user.vim_run_command_exterm("{number}k")
    user.vim_run_command("yy")
(copy | yank) <number_small> lines relative up <number>:
    user.vim_run_command_exterm("{number}k")
    user.vim_run_command("{number_small}yy")
(copy | yank) (above | last) <number_small> lines:
    user.vim_run_normal_exterm("{number_small}k")
    user.vim_run_normal_exterm("y{number_small}y")
    user.vim_run_normal_exterm("{number_small}j")

# duplicating
# These are multi-line like this to perserve INSERT.
# XXX - are temporarily disabled for speed testing
#(duplicate|paste) line <number> on line <number>$:
#    user.vim_run_command(":{number_1}y\n")
#    user.vim_run_command(":{number_2}\n")
#    user.vim_run_command("p")
#(duplicate|paste) lines <number> through <number>$:
#     user.vim_run_command(":{number_1},{number_2}y\n")
#     user.vim_run_command("p")
bring line <number>$:
    user.vim_run_command(":{number}y\n")
    user.vim_run_normal("p")
#(dup|duplicate) line:
#    user.vim_run_normal_np("yy")
#    user.vim_run_normal_np("p")

paste below:
    user.vim_run_normal_np("o")
    user.vim_run_normal("p")

# start ending at end of file
file append:
    user.vim_run_normal_np("Go")

# insert at the end of the current word
jammie:
    user.vim_run_normal_np("ea")
jammie <user.unmodified_key>:
    user.vim_run_normal_np("ea")
    key("{unmodified_key}")

(chompie | chomp here):
    user.vim_run_normal_np("ex")
chomp line:
    user.vim_run_normal_np("$x")
chomp line <number>$:
    user.vim_run_command(":{number}\n")
    user.vim_run_normal_np("$x")

insert <user.text>:
    user.vim_run_insert("{text}")

# helpful for fixing typos or bad lexicons that miss a character
(inject | crammie) <user.unmodified_key> [before]:
    user.vim_run_insert_key("{unmodified_key}")
    # since there is no ctrl-o equiv coming from normal
    key(escape)

(inject | crammie) <user.unmodified_key> after:
    user.vim_run_normal_key("a {unmodified_key}")
    # since we can't perserve mode with ctrl-o
    key(escape)

# XXX - look into how this works
filter line:
    "=="

[add] gap above:
    user.vim_run_command(":pu! _\n")
    user.vim_run_command(":'[+1\n")
[add] gap below:
    user.vim_run_command(":pu _\n")
    user.vim_run_command(":'[-1\n")

# Selects current line in visual mode and triggers a word swap
swap [word] on [this] line:
    key(V)
    insert(":")
    sleep(50ms)
    insert("s///g")
    key(left:3)

swap global:
    user.vim_run_command(":%s///g")
    key(left:3)

global clear:
    user.vim_run_command(":g //d")
    key(left:3)

global inverted clear:
    user.vim_run_command(":v //d")
    key(left:3)

###
# Macros and registers
###
macro play <user.letter>:
    user.vim_run_any_motion("@{letter}")
macro (again | repeat | replay):
    user.vim_run_any_motion("@@")
macro (start | record) <user.letter>:
    user.vim_run_any_motion("q{letter}")
macro (done | finish | stop):
    user.vim_run_any_motion("q")

[copy] register <user.unmodified_key> [in] to [register] <user.unmodified_key>:
    user.vim_run_command(":let@{unmodified_key_2}=@{unmodified_key_1}\n")

yank (into | to) [register] <user.unmodified_key>:
    user.vim_run_any_motion('"{unmodified_key}y')
clear into [register] <user.unmodified_key>:
    user.vim_run_any_motion('"{unmodified_key}d')

# XXX - this should allow counted yanking, into register should become an
# optional part of vim.py matching
# XXX - I can't get this to work
yank <user.vim_text_objects> (into | to) [register] <user.unmodified_key>:
    user.vim_run_any_motion('"{unmodified_key}y{vim_text_objects}')
clear <user.vim_text_objects> (into | to) [register] <user.unmodified_key>:
    user.vim_run_any_motion('"{unmodified_key}d{vim_text_objects}')

(register | registers | macros) list:
    user.vim_run_command(":reg\n")
(register | macro) show <user.letter>:
    user.vim_run_command(":reg {letter}\n")
(register | macro) (edit | modify) <user.letter>:
    user.vim_run_command(":let @{letter}='")
    key(ctrl-r)
    key(ctrl-r)
    insert("{letter}")
    key(')

###
# Folding
###

# creation
fold (row | line):
    user.vim_run_normal("zF")
# NOTE: see vim.py for zf usage

# deletion
fold delete:
    user.vim_run_normal("zd")
fold delete nested:
    user.vim_run_normal("zD")
fold delete all:
    user.vim_run_normal("zE")

# navigation
fold open:
    user.vim_run_normal("zo")
fold open nested:
    user.vim_run_normal("zO")
fold close:
    user.vim_run_normal("zc")
fold close nested:
    user.vim_run_normal("zC")
fold open all:
    user.vim_run_normal("zR")
fold open curse:
    user.vim_run_normal("zv")
fold close all:
    user.vim_run_normal("zM")
fold line <number> through <number>$:
    user.vim_run_normal(":{number_1},{number_2}fo\n")

fold start:
    user.vim_run_normal("[z")
fold end:
    user.vim_run_normal("]z")
fold next:
    user.vim_run_normal("zj")
fold last:
    user.vim_run_normal("zk")

# misc
fold reset:
    user.vim_run_normal("zn")
fold normal:
    user.vim_run_normal("zN")

fold update:
    user.vim_run_normal("zx")
fold undo:
    user.vim_run_normal("zX")

# TODO: folddoo
# TODO: folddoc

###
# Spell check
#
# Recommend you `set spellfile` somewhere
###

toggle spell on:
    user.vim_run_command(":setlocal spell\n")
toggle spell off:
    user.vim_run_command(":setlocal nospell\n")
spell add:
    user.vim_run_normal("zg")
spell wrong:
    user.vim_run_normal("zw")
spell undo add:
    user.vim_run_normal("zug")
spell undo wrong:
    user.vim_run_normal("zuw")
spell (suggest | fix):
    user.vim_run_normal("z=")
spell next:
    user.vim_run_normal("]s")
spell last:
    user.vim_run_normal("[s")

###
# Special Marks
###

(go | jump) [to] last edit:
    user.vim_run_normal("`.")
(go | jump) [to] last insert:
    user.vim_run_normal("`^")
# differences this puts you into insert mode
# TODO - change the way you say this?
(continue | continue last insert):
    user.vim_run_normal("gi")
jump last curse:
    user.vim_run_normal_keys("ctrl-o")
jump next curse:
    user.vim_run_normal_keys("ctrl-I")
jump last line:
    user.vim_run_normal("''")
(go | jump) [to] last change:
    user.vim_run_normal("g;")
(go | jump) [to] next change:
    user.vim_run_normal("g,")
# XXX - add jump to <id>

###
# QuickFix list
###
# XXX - Would be nice to be able to determine if the quickness is actually
# open, and only enable the navigation commands if so...
vim grep:
    user.vim_run_command(":vimgrep // **")
    key(left:4)
vim real grep:
    user.vim_run_command(":grep -r  *")
    key(left:2)
quick [fix] next:
    user.vim_run_command(":cn\n")
quick [fix] (last | back | prev | previous):
    user.vim_run_command(":cp\n")
quick [fix] (show | hide):
    user.vim_run_command(":cw\n")
quick [fix] close:
    user.vim_run_command(":ccl\n")
quick [fix] files:
    user.vim_run_command(":cexpr system(\"fd -g '*.py' .\")")
    key(left:3)

quick [fix] top:
    user.vim_run_command(":cc 1\n")
quick [fix] bottom:
    user.vim_run_command(":cbo\n")
quick [fix] do:
    user.vim_run_command(":cdo | update")
    key(left:8)
quick [fix] swap:
    user.vim_run_command(":cdo s///g| update")
    key(left:11)
quick list older:
    user.vim_run_command(":colder\n")
quick list newer:
    user.vim_run_command(":cnewer\n")
set auto write all:
    user.vim_run_command(":set autowriteall\n")

###
# Location List
###
loke open:
    user.vim_run_command(":lopen\n")
loke close:
    user.vim_run_command(":lclose\n")
loke next:
    user.vim_run_command(":lnext\n")
loke prev:
    user.vim_run_command(":lprev\n")
loke last:
    user.vim_run_command(":llast\n")
loke jump <number>:
    user.vim_run_command(":ll {number}\n")
loke vim grep:
    user.vim_run_command(":lvimgrep // **")
    key(left:4)

###
# Argument list
#
# TODO missing write and movement ex: :wnext
###
(arg | argument) do:
    user.vim_run_command(":argdo | update")
    key(left:9)
    # XXX - using this `<command>` method doesn't seem to be working
(arg | argument) files:
    user.vim_run_command(":arg `fd -g '\\*.py' .`")
    key(left:4)
(arg | argument) list show:
    user.vim_run_command(":arg\n")
(arg | argument) add:
    user.vim_run_command(":argadd ")
(arg | argument) next:
    user.vim_run_command(":next\n")
(arg | argument) previous:
    user.vim_run_command(":prev\n")
(arg | argument) first:
    user.vim_run_command(":first\n")
(arg | argument) last:
    user.vim_run_command(":last\n")

###
# Informational
###
man page this:
    user.vim_run_normal("K")
file info:
    user.vim_run_normal_key(ctrl - g)
# shows buffer number by pressing 2
file extra info:
    user.vim_run_normal_key("2 ctrl-g")
vim help:
    user.vim_run_command_exterm(":help ")
show ask e code:
    user.vim_run_normal_key("g 8")
show last output:
    user.vim_run_normal_key("g <")

display current line number:
    user.vim_run_normal_key(ctrl - g)

###
# Searching
###

# XXX - is it possible to integrate these with vim_motions_with_character?
# ordinals work different for `t` for some reason, so we don't need to -1
till <user.ordinals> <user.unmodified_key>:
    user.vim_run_any_motion("t{unmodified_key}{ordinals};")

till (reversed | previous) <user.ordinals> <user.unmodified_key>:
    user.vim_run_any_motion("T{unmodified_key}{ordinals};")

find <user.ordinals> <user.unmodified_key>:
    user.vim_run_any_motion("f{unmodified_key}{ordinals-1};")

find (reversed | previous) <user.ordinals> <user.unmodified_key>:
    user.vim_run_any_motion("F{unmodified_key}{ordinals-1};")

###
# Visual Text Selection
###
make (ascending | number list | incrementing):
    user.vim_run_normal_key("g ctrl-a")
take line:
    user.vim_run_visual("V")
block take:
    user.vim_run_any_motion_exterm_key("ctrl-v")

take <user.vim_motions>:
    user.vim_run_visual("{vim_motions}")
take <user.vim_text_objects>:
    user.vim_run_visual("{vim_text_objects}")
block take <user.vim_motions>:
    user.vim_visual_block_mode("{vim_motions}")

take lines <number> through <number>:
    user.vim_run_normal_np("{number_1}G")
    user.vim_set_visual()
    insert("{number_2}G")

block take lines <number> through <number>:
    user.vim_run_normal_np("{number_1}G")
    user.vim_set_visual_block()
    insert("{number_2}G")

take <number_small> lines:
    user.vim_set_visual_line()
    insert("{number_small-1}j")

block take <number_small> lines:
    user.vim_set_visual_block()
    insert("{number_small-1}j")

take <number_small> lines at line <number>:
    user.vim_run_normal_np("{number}G")
    user.vim_set_visual_line()
    insert("{number_small-1}j")

block take <number_small> lines at line <number>:
    user.vim_run_normal_np("{number}G")
    user.vim_set_visual_block()
    insert("{number_small-1}j")

take <number_small> above:
    user.vim_run_normal_np("{number_small}k")
    user.vim_set_visual_line()
    insert("{number_small-1}j")

block take <number_small> above:
    user.vim_run_normal_np("{number_small}k")
    user.vim_set_visual_block()
    insert("{number_small-1}j")

take (until | till) line <number>:
    user.vim_run_normal_np("m'")
    insert(":{number}\n")
    user.vim_set_visual_line()
    insert("''")

block take (until | till) line <number>:
    user.vim_run_normal_np("m'")
    insert(":{number}\n")
    user.vim_set_visual_block()
    insert("''")

# Greedily highlight whatever is under the cursor. Doesn't work if on the first
# character of the entry, in which case you should say a normal motion like
# "light big end", etc
take this:
    user.vim_run_normal_np("B")
    user.vim_run_visual("E")

###
# Visual Text Editing
###
prefix <user.vim_select_motion> with <user.unmodified_key>:
    user.vim_run_visual("{vim_select_motion}")
    insert(":")
    # leave time for vim to populate '<,'>
    sleep(50ms)
    insert("s/^/{unmodified_key}/g\n")

###
# Command execution
###
run python script:
    user.vim_run_normal_np(":w\n")
    user.insert_between(":exec '!python3 ", "'")
run sandbox script:
    user.vim_run_normal_np(":w\n")
    user.insert_between(":exec '!env/bin/python3 ", "'")

# Change how these get displayed in splits?
(run make | file build):
    user.vim_run_normal_np(":w\n")
    insert(":!make\n")
run make all:
    user.vim_run_normal_np(":w\n")
    insert(":!make all\n")
run make clean:
    user.vim_run_normal_np(":w\n")
    insert(":!make clean\n")
run make debug:
    user.vim_run_normal_np(":w\n")
    insert(":!make debug\n")
run make kasan:
    user.vim_run_normal_np(":w\n")
    insert(":!make kasan\n")
run bare make:
    user.vim_run_normal_np(":w\n")
    insert(":!bear -- make\n")
run generates see tags:
    user.vim_run_normal_np(":w\n")
    insert(":!rm tags && ctags --recurse --exclude=.git --exclude=.pc *\n")
run lua:
    user.vim_run_command_exterm(":lua ")
run [lua] buffer:
    user.vim_run_command_exterm(":luafile %")

exec repeat:
    user.vim_run_normal_np(":exec ")
    key(up)

script repeat:
    user.vim_run_normal_np(":!")
    key(up)

# Run the current script view the command line
# XXX - These should only enable in python lang mode
invoke this:
    user.vim_run_command(":!%\n")
run as python:
    user.vim_run_normal_np(":w\n")
    insert(":exec '!python' shellescape(@%, 1)\n")
run as bash:
    user.vim_run_normal_np(":w\n")
    insert(":exec '!bash' shellescape(@%, 1)\n")
run as sandbox:
    user.vim_run_normal_np(":w\n")
    insert(":exec '!env/bin/python3' shellescape(@%, 1)\n")

###
# Convenience
###
trim white space:
    user.vim_run_normal(":%s/\\s\\+$//e\n")
(remove all | normalize) tabs:
    user.vim_run_normal(":%s/\\t/    /eg\n")
normalize spaces:
    user.vim_run_command(":%s/\\S\\zs\\s\\+/ /g\n")
normalize new lines:
    user.vim_run_command(":%s/\r//g\n")
(delete | trim) empty lines:
    insert(":")
    sleep(100ms)
    insert("g/^$/d\n")
drop line <number>:
    user.vim_run_command(":{number}d\n")

# remove first byte from a line
pinch:
    user.vim_run_normal("0x")
prefix <user.unmodified_key>:
    user.vim_run_normal("I{unmodified_key}")
squish:
    user.vim_run_command(":s/  / /g\n")
# XXX - this could be a generic talon thing
# XXX - this seems broken if we do it from insert mode
magnet:
    user.vim_run_normal("f ")
    user.vim_run_normal("x")
magnet back:
    user.vim_run_normal("F ")
    user.vim_run_normal("x")

show unsaved changes:
    user.vim_run_command(":w !diff % -\n")

swap again:
    key(g &)

# XXX - should be switched to support any motion mode, but needs np
# which isn't supported yet
go first <user.unmodified_key>:
    user.vim_run_normal_np("^f{unmodified_key}")

    # XXX - should be switched to support any motion mode, but needs np
    # which isn't supported yet
go last <user.unmodified_key>:
    user.vim_run_normal_np("$F{unmodified_key}")

popup clear:
    user.vim_run_command(":call popup_clear(1)")

yank funk:
    user.vim_run_normal("f(Byt(")

# XXX - This should auto detect the current file type, and swap the reference from
# all files
file swap many see:
    user.vim_run_command('!find . -name "*.[ch]" | xargs sed -i -e s///g')
file swap many pie:
    user.vim_run_command('!find . -name "*.py" | xargs sed -i -e s///g')

# These overlap with edit.py, and if we're in something like a pager in the terminal we don't want these to run
scroll top:
    user.vim_run_normal_exterm("zt")
scroll middle:
    user.vim_run_normal_exterm("zz")
scroll bottom:
    user.vim_run_normal_exterm("zb")
# XXX - change these exist scroll top curse ?
scroll top reset cursor:
    user.vim_run_normal_exterm("z\n")
scroll middle reset cursor:
    user.vim_run_normal_exterm("z.")
scroll bottom reset cursor:
    user.vim_run_normal_exterm("z ")
