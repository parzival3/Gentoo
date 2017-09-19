#!/bin/bash

urxvtc -e bash -c "tmux -q -2 has-session && exec tmux -2 attach-session -d || exec
tmux -2 new-session -n$USER -s$USER@$HOSTNAME"
