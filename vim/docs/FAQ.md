# Frequently Asked Questions

## Why not just use raw vim keyboard commands

Some people would suggest that a better approach is to use explicit keyboard
shortcuts and talon alphabet to use VIM, and not break out all of the commands
into distinct grammars. If you feel this is better, simply don't use any of the
provided commands. I chose to do it this way as it feels more natural when
using voice.

## What are some advantages of using talon vim vs raw vim?

You can mix raw vim commands with talon vim interchangeably, you don't have to
entirely which over if you find parts too cumbersome. For example you might
like saying `sit` to go from NORMAL mode to INSERT mode, rather than saying
`insert mode`, and you can continue to do that, which makes sense because it's
faster.

Some of the real convenience comes from just reducing the amount you have to
say over a longer period of time. Even if you're only saying one less word every
command, over the course of an hour or more this adds up a lot.

Some basic convenience comes from more complex sequences of commands combined
with mode switching that happens automatically. For example if you were editing
a line `this is an example sentence` and your cursor is on the word `is` while
in `INSERT` mode. Imagine you want to change the word `sentence` to `line`.
Without using talon vim you would say: `escape fine sun cap word say line`,
with talon vim you would say: `find sun change word say line`

If you use things like VISUAL mode, swapping, buffers, splits, tabs,
terminal, plugins, or any other more advanced vim features they require
lots of key sequences, you will save yourself a significant amount of time and
speaking as more and more words can be eliminated.

Example: If you are in INSERT mode and want to switch to a different buffer you would
need to say: `escape colon bat number enter`. In talon vim you would say
`buffer number`.

Example: If you are in INSERT mode and you decide you want to select five lines
down and then swap cat with dog on the selected lines you would say the
following: `escape vest five jury colon sun slash say cat slash say dog slash gust enter`. With talon vim you would say: `select five lines swap selected say cat go right say dog enter`

It also supports intelligent mode switching, as well as the ability to stay in
INSERT mode despite calling NORMAL mode commands. So you don't need to say
`control urge` or swap in and out. For instance `this is an example sentence`,
if you are in INSERT mode with your cursor on `example` and want to move two
words back you would say `escape two bat sit` or `control urge two bat`,
whereas in talon vim you can just say `two back`

## What are some disadvantages of using talon vim mode?

There are noticeable slow downs in the speed of commands due to not supporting
RPC yet. In order to ensure mode switch occurs artificial delays have to be
introduced so that we can assume the mode has actually changed. In theory this
should get almost immediate once RPC is supported.

There's a lot of commands to learn, and some of them may not be intuitive right
away.
