# Human 2D images to 3D models

Docker image inspired by http://files.is.tuebingen.mpg.de/classner/up/.

## Setup

Before you execute the script: download **SMPL_python_v.1.0.0.zip**
from http://smpl.is.tue.mpg.de/ and put it in the ./models folder. You need an
account to download the package.

```
./prepare.sh
```

Build image:
```
$ docker-compose build
or
$ docker build . -t demo
```

Generate pose prediction:
```
$ docker-compose run demo pose input/debruyne1.jpg
or
$ docker run -it -v "$(pwd)"/input:/input demo bodyfit input/debruyne1.jpg
```

This will generate `.npz` and `.png` files in the `input` folder.

Generate 3D body:
```
$ docker-compose run demo pose input/debruyne1.jpg
or
$ docker run -it -v "$(pwd)"/input:/input demo bodyfit input/debruyne1.jpg
```

## Using nvidia-docker-compose
```
pip install nvidia-docker-compose
# nvidia-docker-compose binary may not be in your path.  On ubuntu, for my installation, it installed to /home/edward/.local/bin/.  An Anaconda installation will have binaries in anaconda/bin.
nvidia-docker-compose build
```

Generate body fit:
```
# Download SMPL_python_v.1.0.0.zip and place in the root directory of this repo on the docker host
nvidia-docker-compose build
nvidia-docker-compose run demo bodyfit /input/zuck1.jpg
```
