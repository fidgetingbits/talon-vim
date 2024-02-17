# Talon-Vim

[talon-vim](https://github.com/fidgetingbits/talon-vim) is a set of talon scripts that allows for convenient interaction
with vim (more focused on neovim). In the [age of
cursorless](https://github.com/cursorless-dev/cursorless), the main benefit from using talon-vim is not for text
editing, but rather for powerful terminal interaction.

- [Talon-Vim](#talon-vim)
  - [UNDER CONSTRUCTION](#under-construction)
  - [Project Layout](#project-layout)
  - [Installation](#installation)
    - [Nix](#nix)
  - [Using Vim Terminals](#using-vim-terminals)
    - [Recommended Terminal Plugins](#recommended-terminal-plugins)
      - [vim-zoom](#vim-zoom)
      - [lualine](#lualine)
  - [Using Vim As Your Editor](#using-vim-as-your-editor)
  - [Using VIM under Talon](#using-vim-under-talon)
  - [Initial Setup Walkthrough](#initial-setup-walkthrough)
    - [Talon Change - The word `yank`](#talon-change---the-word-yank)
    - [Talon Change - The key `end`](#talon-change---the-key-end)
    - [Talon Change - The command `word`](#talon-change---the-command-word)
    - [The `generic_editor.talon` commands](#the-generic_editortalon-commands)
    - [Vim Config Changes](#vim-config-changes)
      - [Detecting VIM running inside terminals from Talon](#detecting-vim-running-inside-terminals-from-talon)
      - [Preventing title truncation](#preventing-title-truncation)
    - [Detecting the code language of edited files](#detecting-the-code-language-of-edited-files)
    - [Detecting current vim mode](#detecting-current-vim-mode)
    - [Automatically switching neovim using RPC](#automatically-switching-neovim-using-rpc)
    - [Using VIM as your terminal](#using-vim-as-your-terminal)
      - [Neovim Terminal Quirks](#neovim-terminal-quirks)
      - [Working directory](#working-directory)
  - [Supported command overview](#supported-command-overview)
    - [Commands](#commands)
    - [Motions](#motions)
    - [Text object selection](#text-object-selection)

## UNDER CONSTRUCTION

talon-vim is currently in the process of being updated after moving out of the [fidgetingbits talon
repo](https://github.com/fidgetingbits/fidgetingbits-talon). Expect lots of documentation voidchanges.

## Project Layout

- `vim`: Core talon-vim functionality and vim-plugins
- `apps`: Terminal utilities that can leverage talon-vim API to add functionality
- `docs`: More per specific documentation for different features

## Installation

Add the following to your `init.lua` (or equivalent).

```lua

```

TODO: Add `vimscript` equivalent question?

### Nix

If you want to try out the exact vim configuration being used by @fidgetingbits, you can install neovim using nix via

```bash
nix run FIXME
```


## Using Vim Terminals

Since this is the most likely use of this talon plugin, all focus on it first. If you actually want to use him for other
basic editing, see the section about editing. Know there is a little bit of overlap because once you're in `NORMAL` or
`VISUAL` mode in the terminal, you'll be using editing commands to copy data, etc. Is just the command sat you'll be
using is more limited.

### Recommended Terminal Plugins

I recommend installing the following plugins if you're going to be using the terminal:

#### [vim-zoom](https://github.com/dhruvasagar/vim-zoom)

Zooms in and out of a split.

FIXME: Include a .gif

#### lualine

Any sort of line plugin that lets you quickly see the mode you're in.

FIXME: Include a screenshot




## Using Vim As Your Editor

## Using VIM under Talon

This document serves as an instruction manual and quick tutorial for people
wanting to set up running vim under talon. Henceforth it will be referred to as
"talon vim". The original inspiration for creating talon vim was vimspeak,
however it has evolved far beyond what vimspeak was able to do.

Most of the testing has been done on Linux, but if you do test this on other
systems and you have positive or negative results you can provide feedback on
the slack channel.

Please note that if you want to have the full vim experience you will have to
make modifications to both the vim config and talon.

Currently supported VIM features:

- motions
- registers
- macros
- folds
- tabs
- splits
- [plugins](plugins) (see list below)
- settings
- automatic mode switching (including terminal)

You can contact `fidget` on the Talon slack for questions/support.

## Initial Setup Walkthrough

### Talon Change - The word `yank`

The default Talon alphabet uses `yank` for the letter `y`. This conflicts with
the natural VIM verb, so it is recommended you change the `y` word in
`code/keys.py`. For example you could instead use: `yell`

### Talon Change - The key `end`

The `code/vim.py` script include support for a motion verb called `end`. To the
problem is that talon also supports the ability to simply say the word `end` and
it will trigger pressing the keyboard key `end`.

You currently have two options to deal with this:

1. You can disable the `end` key in talon, however this will negatively impact
   other scenarios where you would normally like to be able to press key directly.

2. Use the alternate vim motion verb `end word`. There aren't too many
   downside to this approach aside from it being somewhat cumbersome.

### Talon Change - The command `word`

By default talon will use the command `word` as a command for saying a single
word. See `misc/formatters.talon`. In vim "word" is a natural movement motion
so it is included by default. If you decide to use this you will want to
change the talon command to be a separate word.

### The `generic_editor.talon` commands

The default actions defined in `generic_editor.talon` are supported, but in
some cases are too simple for more complicated use with vim. You can try to use
them in general but in some cases you will want to switch to use the vim
specific ones.

### Vim Config Changes

#### Detecting VIM running inside terminals from Talon

The vim support in talon is built around supporting running vim as your
terminal and being able to pop in and out of terminal mode.

If you won't use vim from inside of a terminal you can ignore this step.

Normally by default all terminal grammars will be still loaded when VIM is
running in a terminal, because the app itself that talon detects (at least on
Linux) is the terminal. This takes some manual intervention to fix.

The current fix for this is to modify the `~/.vimrc` configuration file, so
that talon is able to differentiate between vim running in the terminal and the
terminal itself. For instance I add `VIM` in the `titlestring` and this allows
me to set the `vim` talon tag by using `win.title: /VIM/`. It also lets me
descriminate terminal vs vim tags in terminal talon files by using
`not win.title: /VIM/`.

To set your `titlestring` to include `VIM`, use something like the following:

```
let &titlestring ='VIM - (%f) %t'
set title " required for neovim
```

Talon will search the active terminal window title and look for `VIM`, at which
point it will correctly trigger the vim tag and disable the terminal tag.

#### Preventing title truncation

In some scenarios if the window is very narrow the title gets truncated, and
talon isn't able to detect the right information. In order to fix this you can
set the following setting in your vim configuration:

```
let &titlelen = 2048
```

### Detecting the code language of edited files

Currently the logic for detecting the code language inside of vim expect their
actual file name to be the last part of the titlestring that is pulled out of
`win.title`. This means you'll have to added your title string to ensure that
the last entry is the file name. This can be done using the `%t` format
specifier, which was shown in the previous example. No matter what you say your
`titlestring` to just be sure that `%t` is the last entry.

### Detecting current vim mode

`code/vim.py` currently relies on the mode being advertised in the title
string in order to make intelligent decisions about how to flip between modes.
You can disable this functionality in the settings. If you want to use it you
need to make sure that your `titlestring` includes a pattern like `MODE:<mode>`
for example:

```
let &titlestring ='VIM MODE:%{mode()} - (%f) %t'
set title
```

### Automatically switching neovim using RPC

XXX - note this isn't supported yet

Once again we can rely on the `titlestring` to tell talon where to look to
access the current neovim RPC interface.
.

```
let &titlestring ='VIM MODE:%{mode()} RPC:%{v:servername} - (%f) %t'
set title
```

### Using VIM as your terminal

Recent versions of vim and neovim both allow you to run a terminal emulator
inside of a vim buffer itself. For people that are using voice to control their
systems this is actually very useful it allows you to navigate the terminal
history using vim motions. This allows you to for instance copy and paste lines
that were printed from different terminal commands that would otherwise require
you to use a mouse to highlight.

As an alternative to vim you might be tempted to use a terminal that supports
of vim-like selection mode similar to termite, however the selection mode in
these terminals has serious drawbacks such as no line numbers, limited motion
verbs, etc.

If you choose to use them as your terminal than you have to make certain
modifications again to the talon configuration files, and the vim configuration
in order for it to differentiate between terminal mode.

First you'll have to ensure that the vim mode is correctly advertised in your
title string, similar to the previous section. The following example can be
placed into your vim config file.

```
let &titlestring ='VIM MODE:%{mode()} RPC:%{v:servername} - (%f) %t'
set title
if has ('autocmd')
    autocmd TermEnter * let &titlestring='VIM MODE:%{mode()} RPC:%{v:servername} - (%f) %t'|redraw
endif
```

In the example above we need to set up in `autocomd` because by default
terminals were lazily redraw the `titlestring`, which causes talon to not
correctly detect the mode switch.

The `apps/linux/vim_terminal.talon` file can then match based off of the
`titlestring` above holding `MODE:t`, in which case it will trigger `terminal`
mode despite being inside of vim.

#### Neovim Terminal Quirks

XXX - not completed

Here I will try to document some potential problems you will encounter when
moving your workflow into vim terminal for everything, and how I solved them.

https://gist.github.com/DrSpeedy/9022d3bee63a7029570c7d3d43054329

#### Working directory

```
## This function calls the script below when loaded by
## the shell inside of neovim. It must be placed somewhere in
## your default shell's rc file e.g. ~/.zshrc
neovim_autocd() {
    [[ $NVIM_LISTEN_ADDRESS ]] && ${HOME}/.ohmyzsh/custom/functions/neovim-autocd.py
}
chpwd_functions+=( neovim_autocd )
```

## Supported command overview

In this section summarizes most of the main grammars that are supported
by the current talon vim implementation. For the most truthful representation
of what is supported you need to check the talon and python files. All of the
commands follow the typical vim grammar style such as
`[count][action][motion]`. Motions are also supported is to move along where
you are in the file or select things in VISUAL mode. By default these motions
are also accessible for the inside INSERT mode without needing to manually
change modes, to reduce voice strain.

For the most complete as you need to check `vim.py` and `vim.linux.talon`.

### Commands

Many of these can be combined with motions or text objects selection, etc.

```
    "join": "J",
    "filter": "=",
    "paste": "p",
    "undo": "u",
    "swap case": "~",
    "change": "c",
    "delete": "d",
    "trim": "d",
    "indent": ">",
    "unindent": "<",
    "yank": "y",
    "copy": "y",
    "fold": "zf",
    "format": "gq",
    "to upper": "gU",
    "to lower": "gu",
```

### Motions

These are motions that can be used in VISUAL mode, and can also be used as
motions when combined with commands.

```
    "back": "b",
    "back word": "b",
    "big back": "B",
    "big back word": "B",
    "end": "e",
    "end word": "e",
    "big end": "E",
    "word": "w",
    "words": "w",
    "big word": "W",
    "big words": "W",
    "back end": "ge",
    "back big end": "gE",
    "right": "l",
    "left": "h",
    "down": "j",
    "up": "k",
    "next": "n",
    "next reversed": "N",
    "previous": "N",
    "column zero": "0",
    "column": "|",
    "start of line": "^",
    "end of line": "$",
    "search under cursor": "*",
    "search under cursor reversed": "#",
    "again": ";",
    "again reversed": ",",
    "down sentence": ")",
    "sentence": ")",
    "up sentence": "(",
    "down paragraph": "}",
    "paragraph": "}",
    "up paragraph": "{",
    "start of next section": "]]",
    "start of previous section": "[[",
    "end of next section": "][",
    "end of previous section": "[]",
    "matching": "%",
    "down line": "+",
    "up line": "-",
    "first character": "_",
    "cursor home": "H",
    "cursor middle": "M",
    "cursor last": "L",
    "start of document": "gg",
    "start of file": "gg",
    "top of document": "gg",
    "top of file": "gg",
    "end of document": "G",
    "end of file": "G",
```

With character arguments:

```
    "jump to mark": "'",
    "find": "f",
    "find reversed": "F",
    "find previous": "F",
    "till": "t",
    "till reversed": "T",
    "till previous": "T",
    "last": "$F",  ## find starting end of line
```

### Text object selection

```
    "word": "w",
    "words": "w",
    "big word": "W",
    "big words": "W",
    "block": "b",
    "blocks": "b",
    "big block": "B",
    "big blocks": "B",
    "dubquote": '"',
    "dub quote": '"',
    "double quotes": '"',
    "quote": "'",
    "single quotes": "'",
    "ticks": "'",
    "parens": "(",
    "parenthesis": "(",
    "angle brackets": "<",
    "curly braces": "{",
    "braces": "{",
    "square brackets": "[",
    "squares ": "[",
    "brackets": "[",
    "backticks": "`",
    "sentence": "s",
    "sentences": "s",
    "paragraph": "p",
    "paragraphs": "p",
    "tag block": "t",
```
