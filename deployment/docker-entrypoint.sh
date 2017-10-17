#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
# http://stackoverflow.com/questions/19622198/what-does-set-e-mean-in-a-bash-script
set -e

# Define help message
show_help() {
    echo """
Usage: docker run <imagename> COMMAND
Commands
pose     : Generate pose predictions
bodyfit  : Apply bodyfit
render   : Render a fitted body
help     : Show this message
"""
}

# Formats a file and prepends a slash if it isn't present
function format_file() {
  file="${@:1}"
  first_char=${file:0:1}
  if [[ $first_char != "/" ]]; then file="/$file"; fi
  echo $file
}

# Run
case "$1" in
    bash)
        python ${BASE}/setup.py develop > /dev/null 2>&1
        /bin/bash "${@:2}"
    ;;
    pose)
        python ${BASE}/setup.py develop > /dev/null 2>&1
        python pose/pose.py --use_cpu $(format_file ${@:2})
    ;;
    bodyfit)
        python ${BASE}/setup.py develop > /dev/null 2>&1
        python 3dfit/bodyfit.py $(format_file ${@:2})
    ;;
    render)
        python ${BASE}/setup.py develop > /dev/null 2>&1
        python 3dfit/render.py $(format_file ${@:2})
    ;;
    *)
        show_help
    ;;
esac
