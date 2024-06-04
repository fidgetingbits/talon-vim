# Talon-Vim

This is a set of extra commands for controlling neovim using Talon Voice, in combination with the [talonhub
community](https://github.com/talonhub/community/) repo or [my talon repo](https://github.com/fidgetingbits/fidgetingbits-talon)

You probably are looking for [neovim-talon](https://github.com/hands-free-vim/neovim-talon) which is a lighter weight
port of what used to be soley this repo (and previously in my talon repo). It contains most of what you need to use
neovim for managinig terminals with voice, and is meant to be used with
[cursorless](https://github.com/cursorless-dev/cursorless) rather than using native neovim motions.

This repo [talon-vim](https://github.com/fidgetingbits/talon-vim) now relies on neovim-talon to function, but it
contains additional functionality, like lots of convenience, support for many plugins, support for real vim motion.

Due to [cursorless](https://github.com/cursorless-dev/cursorless) being so powerful, I no longer use neovim as my
primary editor, but rather vscode. I do however use neovim as a container for all my terminals, as it allows much more
powerful command-line use (especially with [cursorless.nvim](https://github.com/hands-free-vim/cursorless.nvim/) than a
regular terminal provides.

Note that many parts of this repo will still slowly be migrated to neovim-talon, but it should be relatively seamless.

- [Talon-Vim](#talon-vim)
  - [Dependencies](#dependencies)
  - [Using Vim As Your Editor](#using-vim-as-your-editor)
  - [Using VIM under Talon](#using-vim-under-talon)
    - [Talon Change - The word `yank`](#talon-change---the-word-yank)
    - [Talon Change - The key `end`](#talon-change---the-key-end)
    - [Talon Change - The command `word`](#talon-change---the-command-word)
    - [Neovim Terminal Quirks](#neovim-terminal-quirks)
      - [Working directory](#working-directory)
  - [Supported motion command overview](#supported-motion-command-overview)
    - [Commands](#commands)
    - [Motions](#motions)
    - [Text object selection](#text-object-selection)

## Dependencies

- [talon.nvim](https://github.com/hands-free-vim/talon.nvim/) (Required)
- [neovim-talon](https://github.com/hands-free-vim/neovim-talon) (Required)
- [cursorless.nvim](https://github.com/hands-free-vim/cursorless.nvim/) (Optional)

## Using Vim As Your Editor

I recommend using VSCode for now, until cursorless in neovim supports hats. That said, this repo does support native
vim motions, so you can give it a try.

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

Currently supported VIM features (that aren't in neovim-talon):

- motions
- registers
- macros
- folds
- plugins (see source for list. NOTE: some are in neovim-talon now)
- settings

You can contact `fidgetingbits` on the Talon slack for questions/support.

### Talon Change - The word `yank`

The default Talon alphabet uses `yank` for the letter `y`. This conflicts with
the natural VIM verb, so it is recommended you change the `y` word in your talon
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

### Neovim Terminal Quirks

If you want your Neovim buffer working directory to match the folder your terminal is in, use the following:

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

## Supported motion command overview

All of the commands follow the typical vim grammar style such as
`[count][action][motion]`. Motions are also supported is to move along where
you are in the file or select things in VISUAL mode. By default these motions
are also accessible for the inside INSERT mode without needing to manually
change modes.

### Commands

Many of these can be combined with motions or text objects selection, etc.

```python
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

```python
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

```python
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

```python
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
