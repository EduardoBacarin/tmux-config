#!/bin/sh
#
# Setup a work space called `work` with two windows
# first window has 3 panes. 
# The first pane set at 65%, split horizontally, set to api root and running vim
# pane 2 is split at 25% and running redis-server 
# pane 3 is set to api root and bash prompt.
# note: `api` aliased to `cd ~/path/to/work`
#


# Set Session Name
session="bacarin"
SESSIONEXISTS=$(tmux list-sessions | grep $session)

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s $session -n local #"vim -S ~/.vim/sessions/kittybusiness"

# Split pane 1 horizontal by 65%, start redis-server
tmux splitw -h 

# Select pane 1
tmux select-pane -t 1

# create a new window called scratch
tmux new-window -t $session:1 -n ssh
tmux new-window -t $session:2 -n erl

tmux select-window -t $session:1

# Made a 4x4 window
tmux splitw -h 
tmux select-pane -t 0
tmux splitw -v 
tmux select-pane -t 2
tmux splitw -v


tmux select-window -t $session:2

# Made a 6x6 window
tmux split-window -v
tmux select-pane -t 0
tmux splitw -h 
tmux splitw -h
tmux select-pane -t 3
tmux splitw -h
tmux splitw -h
tmux select-layout tiled
#tmux resize-pane -t 0 -x 3%
#tmux resize-pane -t 1 -x 8%
#tmux resize-pane -t 2 -x 9%
#tmux resize-pane -t 3 -x 7%
#tmux resize-pane -t 4 -x 10%
#tmux resize-pane -t 5 -x 11%
#tmux resize-pane -t 0 -x 79 -y 30
#tmux resize-pane -t 3 -x 79 -y 29
#tmux resize-pane -t 1 -x 79 -y 30
#tmux resize-pane -t 4 -x 79 -y 29
#tmux resize-pane -t 2 -x 79 -y 30
#tmux resize-pane -t 5 -x 79 -y 29


# return to main vim window
tmux select-window -t $session:0

# Finished setup, attach to the tmux session!
fi
tmux attach-session -t $session
