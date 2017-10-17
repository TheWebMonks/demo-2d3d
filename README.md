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
