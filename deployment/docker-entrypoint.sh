#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
# http://stackoverflow.com/questions/19622198/what-does-set-e-mean-in-a-bash-script
set -e

# Define help message
show_help() {
    echo """
Usage: docker run <imagename> COMMAND
Commands
python   : Open a python shell
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

#python ${BASE}/setup.py develop > /dev/null 2>&1 || true

# Run
case "$1" in
    bash)
        /bin/bash "${@:2}"
    ;;
    python)
        python
    ;;
    pose)
        python pose/pose.py --use_cpu $(format_file ${@:2})
    ;;
    bodyfit)
        python 3dfit/bodyfit.py $(format_file ${@:2})
    ;;
    render)
        python 3dfit/render.py $(format_file ${@:2})
    ;;
    segmentation)
        #python segmentation/segmentation.py $(format_file ${@:2}) --part
        python segmentation/segmentation.py $(format_file ${@:2})
    ;;
    version)
        echo "CUDA: "
        nvcc --version || echo "nvcc not installed"
        echo ""
        echo "Python: "
        python --version
        echo ""
        echo "Linux: "
        uname -a
    ;;
    *)
        show_help
    ;;
esac
