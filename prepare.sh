#!/usr/bin/env bash

function fetch() {
  if [ ! -f models/${@:1}.zip ]; then
    echo "Downloading ${@:1}.zip"
    curl -O http://files.is.tuebingen.mpg.de/classner/up/models/${@:1}.zip
    mv ${@:1}.zip models/
  else
    echo "Already downloaded ${@:1}.zip"
  fi
}

fetch 'p91'
fetch 's31'

echo "Download SMPL_python_v.1.0.0.zip from http://smpl.is.tue.mpg.de/ and put it in the ./models folder"
