# VIM Editor Tutorial

This tutorial provides an interactive section where you can test certain
commands and get a feel for how to interact with the VIM plugins.

It also recommended that you check out the youtube videos related to vimspeak
since it is the original project that talon vim was originally ported from. You
could try to follow along with his demos as most of the command should be
supported.

- [vimspeak code demo](https://www.youtube.com/watch?v=TEBMlXRjhZY)
- [vimspeak vim golf demo](https://www.youtube.com/watch?v=qy84TYvXJbk)

## Simple motions and edits

Here you can try out some basic commands to get a feel for the flow of using
the VIM voice commands. Most of the commands should be fairly intuitive.

```
The quick brown fox jumps over the lazy dog.
```

With the cursor starting on the letter `T` above, try practicing with the
following commands. Note that the instructions assume you are viewing this file
from inside vim and it is the only open buffer and split.

Next let's create a little sandbox to work inside.

- `normal mode`
- `new empty vertical split`
- `split rotate`
- `split left`

Next we will set this `vim.md` file to read-only, to help prevent you
accidentally deleting things while experimenting.

- `unset modifiable`

You should now have a new empty vertical split containing on the right side of
your vim screen, and your cursor should be back in the split with the tutorial.

Speak the following commands

- `search reversed lazy dog` (extra space is on purpose to simplify search)
- `enter`
- `yank line`
- `split right`
- `paste above`
- `unset highlights`
- `set line numbers`

Now you should have a new line in the buffer on the right on line number 1.

- `end of line`
- `start of line`
- `word`
- `two word`
- `find run`
- `append`
- `say and under`
- `normal mode`
- `find reversed air`
- `inject space`
- `back`
- `two delete word`
- `find reversed quench`
- `change word`
- `say slow`
- `normal mode`
- `back`
- `swap words`
- `two back`
- `replace gust`
- `yank line`
- `paste below`
- `repeat that twentyieth`
- `top of file`
- `go line ten`
- `gap below`
- `two down`
- `select line`
- `go down`
- `delete`
- `select paragraph`
- `swap selected`
- `say lazy`
- `go right`
- `say hyper`
- `enter` (this might be mapped differently for you. how ever you say press enter)
- `reselect`
- `swap selected`
- `space`
- `go right`
- `dash`
- `swap global`
- `backslash dot`
- `go right`
- `bang`
- `enter` (this might be mapped differently for you. however you press enter)

All done for now. You can close the sandbox buffer:

- `force close this buffer`

This really only touches the surface of the commands supported. You will need
to spend time reading `vim.talon`, `vim.py`, and experimenting to get a feel
for everything.
