#!/bin/bash

VENV_DIR=".venv"

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv $VENV_DIR
    echo "virtual envirement created ✔️"
    pip install -r requirements.txt
    echo "requirements installed ✔️"
fi



SESSION_NAME="blog-dev"

if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
    tmux new-session -d -s $SESSION_NAME
    tmux send-keys "bash" C-m

    # bottom tab
    tmux split-window -v
    tmux send-keys "bash" C-m
    tmux send-keys "source .venv/bin/activate && clear" C-m
    tmux select-pane -U

    # top right tab
    tmux split-window -h
    tmux send-keys "bash" C-m
    tmux send-keys "source .venv/bin/activate && clear" C-m
    tmux send-keys "python manage.py tailwind start" C-m
    tmux select-pane -L

    # top left tab
    tmux send-keys "source .venv/bin/activate && clear" C-m

    if ! test -f "db.sqlite3"; then
        tmux send-keys "python manage.py migrate" C-m
    fi

    tmux send-keys "python manage.py runserver" C-m
    tmux select-pane -D

    echo "session created successfully ✔️"
    echo "run 'bash dev.sh' one more time to connect to the session"
else
    tmux attach-session -t $SESSION_NAME
fi