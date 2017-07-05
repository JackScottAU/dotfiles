#!/bin/bash

## Bash log-out script. Run when an interactive session closes.

# Clear the console (not that it's useful via SSH).
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
