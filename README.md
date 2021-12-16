# Top Prompt

### Keep the bash prompt at the top of the window instead of the bottom

First prototype of making a tmux environment that has just the prompt at the top of a window, and all the output in the rest of it. 

Everything shows up in both panes, but since the top pane is small it's mostly just the prompt up there.  

This has an advantage over the main version that you can switch to the bottom pane and type stuff in there if you want, and nothing should break (they're the exact same screen session)

## Requirements

tmux
screen
bash

## Notes

It's just 2 tmux panes, both connected to the same screen session.  