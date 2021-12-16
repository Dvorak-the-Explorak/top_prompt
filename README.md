# Top Prompt

### Keep the bash prompt at the top of the window instead of the bottom

This sets up a tmux environment with a small pane at the top which only shows the bash prompt and commands as you type them, and a larger pane at the bottom where everything appears as usual.  

## FREE JANK

This is not a clean utility.  

- It's barely tested!
- Sometimes it just tears the tmux environment apart and leaves you in a weird broken terminal (just close tmux if that happens)
- The bottom pane is a separate bash window that you can switch to, run commands, and confuse everything
- The bash scripts reference eachother by name and haven't been set up to work anywhere except your home directory
- filter_prompt.sh may fail miserably in some circumstances, I dunno.  
- If your commands go over 2 lines, they'll scroll out of view of the top pane. 

## Requirements

tmux
bash


## Usage

V1, has a bit of manual setup.  

- Put the 2 bash files in the same folder
- edit the `ps1` and `ps2` variables in filter_prompt.sh to your prompt strings
- remove the warning about doing that step from top_prompt.sh
- run top_prompt.sh (doesn't need to be sourced)

It'll open a tmux environment, with the prompt area at the top focused.
You need to type in here, as the bottom pane 

## Notes

All it's doing is redirecting the top pane's outputs. 

- stdout and stderr both go to the bottom pane
- stderr also goes through a filter and shows in the top pane

The filter keeps track of whether it's on a line starting with the given (hardcoded) prompt string, and only keeps characters from those lines. 

I wrote it all in bash for some reason.
