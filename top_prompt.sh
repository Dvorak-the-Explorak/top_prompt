#!/bin/bash

# echo -e "WARNING This program is hella jank. \nSet the prompt string variables manually in filter_prompt.sh,\n\tthen delete this error line (in $0)." >&2  && exit


if [ $# -eq 0 ] 
then
	SESSION="TopPrompt"
else
	# argument given, use it as session name
	SESSION=$1
fi

# Try to attach to existing session
#	if it attaches, we're done
if $(tmux a -t $SESSION &> /dev/null); then
	exit
fi


# Set the command line arguments $1 and $2 to be 
#	rows and columns of the current terminal
# ("--" says everything after is an argument, not an option/flag)
set -euo pipefail -- $(stty size)

# width of tmux window
width=$2
# height of tmux window (tmux adds a status line at the bottom)
height=$(($1 -1))


# Start a tmux session with same size as current window 
#	(y is one less because there's a tmux status line at the bottom)
tmux new-session -d -s $SESSION -x $width -y $height

# split the window vertically, make the top pane 2 lines tall
#	by specifying the height of the bottom pane
# 		(accounting for the separating line)
#	bottom pane (1) will be selected
tmux split-window -v -l $(($height - 3))


# ================================
#			Bottom pane
# ================================
tmux send-keys "tty > /tmp/log" C-m


# set the bottom pane to have no promptstring
tmux send-keys "export PS1=''" C-m

# tmux wait -S sends a message that the session is open
#	(this should run inside the screens session)
tmux send-keys "tmux wait -S ${SESSION}TTY" C-m

# Hide all our nastiness
tmux send-keys "clear" C-m

# target is the tty we'll redirect stuff to
target=$(cat /tmp/log)


# ================================
#			Top pane
# ================================

# Select the top pane
tmux select-pane -t 0

# Wait to make sure tty results are in
tmux wait ${SESSION}TTY

# redirect stdout and stderr to other pane
tmux send-keys "exec 2> >(tee ${target} | bash filter_prompt.sh >&2) >${target}" C-m
tmux send-keys "" C-m

# Go into session
tmux attach -t $SESSION