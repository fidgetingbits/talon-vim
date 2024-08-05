import logging
import pprint
import sys
import time
from pathlib import Path

from talon import Context, Module, actions, app, settings, ui

sys.path.insert(1, f"{Path.home()}/.talon/user/neovim-talon")

from core.rpc.api import VimAPI

try:
    import pynvim

    has_pynvim = True
except Exception:
    has_pynvim = False

logger = logging.getLogger("talon.vim")


mod = Module()
ctx = Context()


# talon vim plugins. see apps/vim/plugins/
# to enable plugins you'll want to set these inside the corresponding mode
# talon file.
# XXX - that should just be automatically done based off the file names inside
# of the plugin folder since it's annoying to manage
# TODO: It would be good to mark some of these with nvim if their specific to neovim
plugin_tag_list = [
    "vim_ale",
    "vim_change_inside_surroundings",
    "vim_codeql",
    "vim_comment_nvim",
    "vim_copilot",
    "vim_cscope",
    "vim_easy_align",
    "vim_easymotion",
    "vim_eunuch",
    "vim_fern",
    "vim_fern_mapping_fzf",
    "vim_floaterm",
    "vim_fugitive",
    "vim_fugitive_summary",
    "vim_fzf",
    "vim_grammarous",
    "vim_lightspeed",
    "vim_leap",
    "vim_lsp",
    "vim_markdown",
    "vim_markdown_preview",
    "vim_markdown_toc",
    "vim_mason",
    "vim_mkdx",
    "vim_null_ls",
    "vim_follows_md_links",
    "vim_lazy",
    "vim_nerdtree",
    "vim_obsession",
    "vim_plug",
    "vim_rooter",
    "vim_signature",
    "vim_suda",
    "vim_surround",
    "vim_taboo",
    "vim_tabular",
    "vim_taskwiki",
    "vim_telescope",
    "vim_test",
    "vim_treesitter",
    "vim_treesitter_textobjects",
    "vim_unicode",
    "vim_ultisnips",
    "vim_wiki",
    "vim_you_are_here",
    "vim_youcompleteme",
    "vim_zenmode",
    "vim_zoom",
    "vim_trouble",
    "vim_luasnip",
    "vim_nvim_cmp",
    "vim_flip_ext",
]
for entry in plugin_tag_list:
    mod.tag(entry, f"tag to load {entry} vim plugin commands")


ctx.lists["self.vim_arrow"] = {
    "left": "h",
    "right": "l",
    "up": "k",
    "down": "j",
}

# XXX - need to break into normal, visual, etc
# XXX - Technically some of these are not counted atm... so could be split
# Standard self.vim_counted_actions insertable entries
standard_counted_actions = {
    "suffix": "a",
    "append": "a",
    "suffix line": "A",
    "insert mode": "i",
    "insert column zero": "gI",
    "open below": "o",
    # "open above": "O",
    # opposite is useful for visual mode cursor swapping
    "opposite": "o",
    "substitute": "s",
    "substitute line": "S",
    "undo": "u",
    "regret": "u",
    "undo line": "U",
    "regret line": "U",
    # "erase": "x",
    "forget": '"_x',
    "erase reversed": "X",
    "paste": "p",
    "paste above": "P",
    "repeat": ".",
    "forget line": '"_dd',  # TODO - can we avoid because of clear line?
    # "yank line": "Y", # XXX - this has mode specific implementations now
    # "copy line": "Y",
    "scroll left": "zh",
    "scroll right": "zl",
    "scroll half screen left": "zH",
    "scroll half screen right": "zL",
    "scroll start": "zs",
    "scroll end": "ze",
    "upper line": "gUU",
    "lower line": "guu",
    # XXX - these work from visual mode and normal mode
    "prefix": "I",
    "play again": "@@",
    "toggle case": "~",
    "repeat last swap": "&",
    "dedent": "<<",
    "indent": ">>",
    "drop": "x",
    "open above": "O",
}


# Standard self.vim_counted_actions key() entries
standard_counted_actions_control_keys = {
    "redo": "ctrl-r",
    "scroll": "ctrl-f",
    "punk": "ctrl-b",
    "half down": "ctrl-d",
    "half up": "ctrl-u",
    "increment": "ctrl-a",
    "decrement": "ctrl-x",
}

# Custom self.vim_counted_actions insertable entries
# You can put custom aliases here to make it easier to manage. The idea is to
# alias commands from standard_counted_actions above, without replacing them
# there to prevent merge conflicts.
custom_counted_action = {}

# Custom self.vim_counted_actions insertable entries
# You can put custom shortcuts requiring key() here to make it easier to manage
custom_counted_actions_control_keys = {}

ctx.lists["self.vim_counted_actions"] = {
    **standard_counted_actions,
    **custom_counted_action,
}

ctx.lists["self.vim_counted_actions_keys"] = {
    **standard_counted_actions_control_keys,
    **custom_counted_actions_control_keys,
}

ctx.lists["self.vim_jump_range"] = {
    "jump to line of": "'",
    "jump to character of": "`",
}

ctx.lists["self.vim_jumps"] = {
    "start of last selection": "<",
    "end of last selection": ">",
    "latest jump": "'",
    "last exit": '"',
    "last insert": "^",
    "last change": ".",
}

ctx.lists["self.vim_counted_actions_args"] = {
    "macro play": "@",  # takes char arg
}

#  XXX - We need to break this up so that commands related to thing that
#  requires a motion can't be triggered otherwise, are only if they're in there
#  associated mode. For instance fold shouldn't be something that can be
#  triggered from normal or insert unless it's followed by some motion, whereas
#  in visual mode it's fine.
# normal mode commands that require motion, and that are counted
# includes motions and no motions :|
commands_with_motion = {
    # no motions
    "join line": "J",  # join alone too often conflicts with junkvim
    "merge": "gJ",  # won't produce spaces between joined words
    # "filter": "=",  # XXX - not sure about how to use this
    "paste": "p",  # XXX this really have motion
    "undo": "u",  # XXX this really have motion
    "regret": "u",  # XXX this really have motion
    "swap case": "~",
    # motions
    "change": '"_c',  # NOTE: we purposely use the black hole register
    "clear": "d",  # this is to be consistent with talon generic_editor.talon
    "forget": '"_d',  # this is to be consistent with talon generic_editor.talon
    "indent": ">",
    "unindent": "<",
    "yank": "y",  # NOTE: conflicts with talon 'yank' alphabet for 'y' key
    "copy": "y",
    "fetch": "y",
    "fold": "zf",
    "format": "gq",
    "to upper": "gU",
    "to lower": "gu",
    # comment.nvim
    # "comment": "gc",
    # "comment outer": "gca",
    # "comment inner": "gci",
}

# TODO: That should get moved to the visual mode file now

# only relevant when in visual mode. these will have some overlap with
# commands  and commands_with_motion above. this is mostly because
# some characters differ, and also in visual mode they don't have motions
visual_commands = {
    # normal overlap
    "change": '"_c',  # NOTE: we purposely use the black hole register
    "join lines": "J",
    "clear": "d",  # this is to be consistent with talon generic_editor.talon
    "forget": '"_d',  # this is to be consistent with talon generic_editor.talon
    "yank": "y",  # NOTE: conflicts with talon 'yank' alphabet for 'y' key
    "format": "gq",
    "fold": "zf",
    # some visual differences
    "to upper": "U",
    "to lower": "u",
    "swap case": "~",
    "opposite": "o",
    # counted
    "indent": ">",
    "unindent": "<",
}


ctx.lists["self.vim_motion_commands"] = list(
    set().union(commands_with_motion.keys(), visual_commands.keys())
)

# note that some of these are disabled to reduce the rule explosion to make
# things faster, where you can enable some if your detection is bad for the
# ones that are already enabled
# XXX - find a better name for the "big <thing>" names?
motions = {
    "back": "b",
    "big back": "B",
    "backie": "B",
    "tippy": "e",  # tip conflicts with other stuff
    "big tippy": "E",
    "word": "w",
    "big word": "W",
    "biggie": "W",
    # "tail": "ge",
    # "big tail": "gE",
    "right": "l",
    "left": "h",
    # "down": "j",
    "south": "j",
    # "up": "k",
    "north": "k",
    "next": "n",
    "previous": "N",
    "column zero": "0",
    "column": "|",
    "start of line": "^",
    "bend": "^",
    "lend": "$",
    "curse search": "*",
    "curse search reversed": "#",
    # TODO - make easier to remember/say
    "again": ";",
    "again reversed": ",",
    "tense": ")",
    "last tense": "(",
    "graph": "}",
    "last graph": "{",
    #    "section": "]]",
    #    "last section": "[[",
    "end section": "][",
    "last end section": "[]",
    # XXX - not sure about naming - don't seem to work yet
    "block end": "]}",
    "block start": "[{",
    "last block": "[}",
    "matching": "%",
    "down line": "+",
    "up line": "-",
    "first character": "_",
    "curse top": "H",
    "curse middle": "M",
    "curse last": "L",
    # "loft": "gg",
    # "file top": "gg",
    "gutter": "G",
    # "file ent": "G",
    "change": "]c",
    "last change": "[c",
}

# XXX - These come from treesitter-textobjects, so should really be injected
# from that .py
treesitter_motions = {
    "funk start": "[m",
    "funk next": "]m",
    "class start": "[[",
    "class next": "]]",
    "comment start": "[/",
    "comment next": "]/",
    "loop start": "[l",
    # "loop": "[l",
    "loop next": "]l",
    "condition start": "[C",
    # "condition": "[C",
    "condition next": "]C",
}


motions_custom = {}

ctx.lists["self.vim_motions"] = {
    **motions,
    **motions_custom,
    **treesitter_motions,
}


# TODO - Not sure if curse always applies
ctx.lists["self.vim_motions_keys"] = {
    "last curse": "ctrl-o",
    "next curse": "ctrl-i",
    # "retrace movements": "ctrl-o",
    # "retrace movements forward": "ctrl-i",
}

# all of these motions take a character argument
vim_character_motions = {
    "mark": "'",
    "find": "f",
    "fever": "F",
    "till": "t",
    # XXX - tier caused way too many problem
    "timber": "T",
}

custom_vim_motions_with_character_commands = {
    # XXX - these don't work due to comboing had to be moved into commands in a
    # talon file
    #    "last": "$F",  # find starting end of line
    #    "first": "^f",  # find starting beginning of line
}

ctx.lists["self.vim_motions_with_character"] = {
    **vim_character_motions,
    **custom_vim_motions_with_character_commands,
}


# all of these motions take a phrase argument
ctx.lists["self.vim_motions_with_phrase"] = {
    "search": "/",
    "search reversed": "?",
}

ctx.lists["self.vim_text_object_range"] = {
    "inner": "i",
    "inside": "i",
    "around": "a",
    "out side": "a",
    "outer": "a",
    "this": "a",
}

# Common names used for text object selection, vim-surround, etc
common_key_names = {
    "tick": "'",
    "quote": '"',
}


# XXX - Should match more wording in vim_surround_targets
# These can be pluralized because of how you speak vim grammars
# ex: yank inside braces
# however in practice talon matches them any ways
text_object_select = {
    "word": "w",
    "big word": "W",
    "block": "b",
    "big block": "B",
    "quote": '"',
    "tick": "'",
    "parens": "(",
    "round": "(",
    "angles": "<",
    "code block": "{",
    "braces": "{",
    "squares ": "[",
    "graves": "`",
    "sentence": "s",
    "graph": "p",
    "tag block": "t",
    "funk": "f",  # This is for around or iner
    "condition": "m",
    "loop": "l",
    "class": "c",
    "comment": "/",
}

text_object_select_custom = {}

ctx.lists["self.vim_text_object_select"] = {
    **text_object_select,
    **text_object_select_custom,
}

# Specific to the vim-surround plugin
# XXX - should be able to partially mix with earlier list
# XXX - should actually move to surround plugin
# XXX - revisit loose naming
# XXX - things like word, etc should probably be switched? I'm not sure what
# they do...
ctx.lists["self.vim_surround_targets"] = {
    "stars": "*",
    "word": "w",
    "big word": "W",
    "block": "b",
    "big block": "B",
    "quotes": '"',
    "ticks": "'",
    "loose parens": "(",
    "loose round": "(",
    "loose angles": "<",
    "loose braces": "{",
    "loose squares": "[",
    "round": ")",
    "parens": ")",
    "angles": ">",
    "braces": "}",
    "squares": "]",
    "graves": "`",
    "gravy": "```",
    "sentence": "s",
    "paragraph": "p",
    "spaces": "  ",  # double spaces is required because surround gets confused
    "tags": "t",
    "H one tags": "<h1>",
    "H two tags": "<h2>",
    "div tags": "<div>",
    "bold tags": "<b>",
}

# settings that you can just set by sing on or off
# correlates to settings that start with no in turning off
vim_on_and_off_settings = {
    "see indent": "cindent",
}

mod.tag("vim", desc="a tag to load various vim plugins")
mod.tag("vim_terminal", desc="a tag to designate if we are in a vim terminal")
mod.setting(
    "vim_preserve_insert_mode",
    type=int,
    default=1,
    desc="If normal mode actions are called from insert mode, stay in insert",
)

mod.setting(
    "vim_adjust_modes",
    type=int,
    default=1,
    desc="User wants talon to automatically adjust modes for commands",
)

mod.setting(
    "vim_notify_mode_changes",
    type=int,
    default=0,
    desc="Notify user about vim mode changes as they occur",
)

mod.setting(
    "vim_escape_terminal_mode",
    type=int,
    default=0,
    desc="When set won't limit what motions and commands will pop out of terminal mode",
)
mod.setting(
    "vim_cancel_queued_commands",
    type=int,
    default=1,
    desc="Press escape before issuing commands, to cancel previously queued command that might have been in error",
)

mod.setting(
    "vim_cancel_queued_commands_timeout",
    type=float,
    default=0.05,
    desc="How long to wait in seconds before issuing the real command after canceling",
)

mod.setting(
    "vim_mode_change_timeout",
    type=float,
    default=0.2,
    desc="It how long to wait before issuing commands after a mode change",
)

mod.setting(
    "vim_mode_switch_moves_cursor",
    type=int,
    default=0,
    desc="Preserving insert mode will automatically move the cursor. Setting this to 0 can override that.",
)

mod.setting(
    "vim_use_rpc",
    type=int,
    default=0,
    desc="Whether or not to use RPC if it is available. Useful for testing or avoiding bugs",
)
mod.setting(
    "vim_debug",
    type=int,
    default=0,
    desc="Debugging used for development",
)


# Standard VIM motions and action
mod.list("vim_arrow", desc="All vim direction keys")
mod.list("vim_motion_commands", desc="Counted VIM commands with motions")
# mod.list("vim_counted_motions", desc="Counted VIM motion verbs")
mod.list("vim_counted_actions", desc="Counted VIM action verbs")
mod.list("vim_counted_actions_keys", desc="Counted VIM action verbs ctrl keys")
mod.list(
    "vim_counted_actions_args", desc="Counted VIM action verbs with keyi arguments"
)
mod.list("vim_normal_counted_action", desc="Normal counted VIM actions")
mod.list("vim_normal_counted_actions_keys", desc="Counted VIM action verbs ctrl keys")
mod.list("vim_motions", desc="Non-counted VIM motions")
mod.list("vim_motions_keys", desc="Non-counted VIM motions ctrl keys")
mod.list("vim_motions_with_character", desc="VIM motion verbs with char arg")
mod.list("vim_motions_with_phrase", desc="VIM motion verbs with phrase arg")
mod.list("vim_motions_all", desc="All VIM motion verbs")
mod.list("vim_text_object_range", desc="VIM text object ranges")
mod.list("vim_text_object_select", desc="VIM text object selections")
mod.list("vim_jump_range", desc="VIM jump ranges")
mod.list("vim_jumps", desc="VIM jump verbs")
mod.list("vim_jump_targets", desc="VIM jump targets")
mod.list("vim_normal_counted_motion_command", desc="Counted normal VIM commands")
mod.list("vim_counted_motion_command_with_ordinals", desc="Counted normal VIM commands")
mod.list("vim_select_motion", desc="VIM visual mode selection motions")

# Plugin-specific lists
mod.list("vim_surround_targets", desc="VIM surround plugin targets")

# Plugin modes
mod.mode("vim_fugitive", desc="A fugitive mode that exposes git mappings")


@mod.capture(rule="{self.vim_arrow}")
def vim_arrow(m) -> str:
    "An arrow direction to be converted to vim direction"
    return m.vim_arrow


@mod.capture(rule="{self.vim_text_object_select}")
def vim_text_object_select(m) -> str:
    "Returns a string representing a selection text object"
    return m.vim_text_object_select


@mod.capture(rule="{self.vim_text_object_range}")
def vim_text_object_range(m) -> str:
    "Returns a string ranged text object"
    return m.vim_text_object_range


@mod.capture(rule="{self.vim_motions}")
def vim_motions(m) -> str:
    "Returns to string representing motion verb"
    return m.vim_motions


@mod.capture(rule="{self.vim_motions_keys}")
def vim_motions_keys(m) -> str:
    "Returns a key representing a motion"
    return m.vim_motions_keys


@mod.capture(
    rule="{self.vim_motions_with_character} (ship|upper|uppercase) <user.letter>"
)
def vim_motions_with_upper_character(m) -> str:
    "Returns a motion string with an upper case character"
    return m.vim_motions_with_character + "".join(list(m)[2:]).upper()


@mod.capture(
    rule="{self.vim_motions_with_character} (<user.letter>|<digits>|<user.symbol_key>)"
)
def vim_motions_with_character(m) -> str:
    "Returns a motion with a character argument"
    return m.vim_motions_with_character + "".join(str(x) for x in list(m)[1:])


@mod.capture(rule="{self.vim_motions_with_phrase} <user.text>")
def vim_motions_with_phrase(m) -> str:
    "Returns a motion with a phrase argument"
    return "".join(list(m.vim_motions_with_phrase + m.text))


@mod.capture(
    rule="[<user.number_string>] (<self.vim_motions>|<self.vim_motions_with_character>|<self.vim_motions_with_upper_character>|<self.vim_motions_with_phrase>)"
)
def vim_motions_all(m) -> str:
    "Returns a rule matching optionally numbered vim motion"
    return "".join(list(m))


@mod.capture(
    rule="[<user.number_string>] (<self.vim_motions>|<self.vim_motions_with_character>|<self.vim_motions_with_upper_character>|<self.vim_motions_with_phrase>)"
)
def vim_motions_all_adjust(m) -> str:
    "Returns a rule matching a vim motion, and adjusts the vim mode"
    v = VimAPI()
    v.set_any_motion_mode()
    # print(m)
    return "".join(list(m))


@mod.capture(rule="{self.vim_counted_actions}")
def vim_counted_actions(m) -> str:
    "Returns string matching accounted action"
    return m.vim_counted_actions


@mod.capture(rule="{self.vim_counted_actions_keys}")
def vim_counted_actions_keys(m) -> str:
    "Returns key matching accounted action"
    return m.vim_counted_actions_keys


# @ctx.capture(rule="[<number_small>] <self.vim_motions_all>")
# def vim_counted_motions(m) -> str:
#    return "".join(str(x) for x in list(m))


@mod.capture(rule="{self.vim_jump_range}")
def vim_jump_range(m) -> str:
    "Returns a string representing a ranged jump"
    return m.vim_jump_range


@mod.capture(rule="{self.vim_jumps}")
def vim_jumps(m) -> str:
    "Returns a string representing a jump target"
    return m.vim_jumps


@mod.capture(rule="{self.vim_surround_targets}")
def vim_surround_targets(m) -> str:
    "Returns a string representing a vim surround plugin target"
    return m.vim_surround_targets


@mod.capture(rule="<self.vim_jump_range> <self.vim_jumps>")
def vim_jump_targets(m) -> str:
    "Returns a string representing a ranged jump target"
    return "".join(list(m))


@mod.capture(
    # XXX - trying to reduce list sizes and never use this
    rule="[<number_small>] [<self.vim_text_object_range>] <self.vim_text_object_select>"
    # rule="<self.vim_text_object_range> <self.vim_text_object_select>"
)
def vim_text_objects(m) -> str:
    "Returns a string representing a ranged texts objects selection"
    return "".join(str(x) for x in list(m))


# Sometimes you want to imply a surround action is going to work on a word, but
# saying around is tedious, of this is defaults to selecting around if no
# actual inner or around range is spoken
@mod.capture(rule="[<number_small>] <self.vim_text_object_select>")
def vim_unranged_surround_text_objects(m) -> str:
    "Returns a string representing an unranged surround plugin target"
    if len(list(m)) == 1:
        return "a" + "".join(list(m))
    else:
        return "".join(str(m.number_small)) + "a" + "".join(list(m)[1:])


@mod.capture(rule="{self.vim_motion_commands}")
def vim_motion_commands(m) -> str:
    "Returns a string representing a motion command"
    v = VimAPI()
    if v.is_visual_mode():
        if str(m) in visual_commands:
            return visual_commands[str(m)]
    # Note this throws away commands that matched visual mode only stuff,
    # because if not in visual mode already, there is no selection anyway so
    # the command is moot
    elif str(m) not in commands_with_motion:
        print(f"no match for {str(m)}")
        return ""

    v.set_normal_mode()
    return commands_with_motion[str(m)]


@mod.capture(
    rule="[<number_small>] <self.vim_motion_commands> [(<self.vim_motions_all> | <self.vim_text_objects> | <self.vim_jump_targets>)]"
)
def vim_normal_counted_motion_command(m) -> str:
    "Returns a string representing a motion command with optional arguments"
    return "".join(str(x) for x in list(m))


@mod.capture(
    rule="<self.vim_motion_commands> <user.ordinals> (<self.vim_motions_all>|<self.vim_jump_targets>)"
)
def vim_counted_motion_command_with_ordinals(m) -> str:
    "Returns a string of a motion command with optional counted argument"
    return "".join([str(m.ordinals - 1), "".join(m[2:]), m[0], "".join(m[2:])])


@mod.capture(rule="[<number_small>] <self.vim_motions_keys>")
def vim_normal_counted_motion_keys(m) -> str:
    "Returns a string of a counted motion representing keys"
    # we do this because we pass everything to key() which needs a space
    # separated list
    if len(str(m).split(" ")) > 1:
        return " ".join(list((" ".join(list(str(m.number_small))), m.vim_motions_keys)))
    else:
        return m.vim_motions_keys


# XXX - could combine actions_keys and _action version by test if the entry is
# in which list. might reduce number usage?
@mod.capture(rule="[<number_small>] <self.vim_counted_actions>")
def vim_normal_counted_action(m) -> str:
    "Returns a string of a counted motion"
    # XXX - may need to do action-specific mode checking
    v = VimAPI()
    v.cancel_queued_commands()
    if m.vim_counted_actions == "u":
        # undo doesn't work with ctrl-o it seems
        v.set_any_motion_mode_np()
    else:
        v.set_any_motion_mode()

    return "".join(str(x) for x in list(m))


@mod.capture(rule="[<number_small>] <self.vim_counted_actions_keys>")
def vim_normal_counted_actions_keys(m) -> str:
    "Returns a string of a counted action representing keys"
    v = VimAPI()
    v.cancel_queued_commands()
    v.set_any_motion_mode()

    # we do this because repass everything to key() which needs a space
    # separated list
    if len(str(m).split(" ")) > 1:
        return " ".join(
            list((" ".join(list(str(m.number_small))), m.vim_counted_actions_keys))
        )
    else:
        return m.vim_counted_actions_keys


@mod.capture(
    rule="[<number_small>] (<self.vim_motions> | <self.vim_text_objects> | <self.vim_jump_targets>)"
)
def vim_select_motion(m) -> str:
    "Returns a string of some selection motion"
    return "".join(str(x) for x in list(m))


# @ctx.action_class("main")
# class main_actions:
#    def insert(text):
#        """override insert action to allow us to enter insert mode"""
#        v = VimAPI()
#        v.set_insert_mode()
#        scripting.core.MainActions.insert(text)


class NoEpollSelectorSpam(logging.Filter):
    def filter(self, record):
        return not record.getMessage().endswith("DEBUG Using selector: EpollSelector")


logging.getLogger("asyncio").setLevel(logging.ERROR)
