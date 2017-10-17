# Human 2D images to 3D models

Docker image inspired by http://files.is.tuebingen.mpg.de/classner/up/.

## Setup

Download the `test2.caffemodel`. We're not downloading it during the
docker build, this will take to much time.
```
./prepare.sh
```

Build image:
```
docker-compose build
```

Generate pose prediction:
```
docker-compose run demo pose /input/zuck1.jpg
```

This will generate `.npz` and `.png` files in the `input` folder.


## Using nvidia-docker-compose
```
pip install nvidia-docker-compose
# nvidia-docker-compose binary may not be in your path.  On ubuntu, for my installation, it installed to /home/edward/.local/bin/.  An Anaconda installation will have binaries in anaconda/bin.
nvidia-docker-compose build
```

Generate body fit:
```
# Download SMPL_python_v.1.0.0.zip and place in the root directory of this repo in the docker host
nvidia-docker-compose build
nvidia-docker-compose run demo bodyfit /input/zuck1.jpg
```
