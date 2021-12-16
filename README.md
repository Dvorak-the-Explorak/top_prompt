# Top Prompt

### Keep the bash prompt at the top of the window instead of the bottom

This sets up a tmux environment with a small pane at the top which only shows the bash prompt and commands as you type them, and a larger pane at the bottom where everything appears as usual.  

## FREE JANK

This is not a clean utility.  

- It's barely tested!
- The bottom pane is a separate bash window that you can switch to, run commands, and confuse everything
- The bash scripts reference eachother by name and haven't been set up to work anywhere except your home directory
- filter_prompt.sh may fail miserably in some circumstances, I dunno.  
- If your commands go over 2 lines, they'll scroll out of view of the top pane.  