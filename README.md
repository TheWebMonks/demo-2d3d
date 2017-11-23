# Human 2D images to 3D models

Project to put the [Unite the People](http://files.is.tuebingen.mpg.de/classner/up/)
project in a Docker image. The project contains 2 docker images because the
*pose* and *segmentation* scripts require different environments.

* **up_caffe**: run the pose prediction with the *p91* model
* **up_deeplab**: run the segmentation script with the *s31* model

## Usage

When you `run` the containers you need to mount a local folder which contains
the source images that you want to use for pose predictions and segmentations.

### 1. Download

```
$ docker pull lukin0110/up_caffe
$ docker pull lukin0110/up_deeplab
```
### 2. Execute pose prediction

```
$ docker run -it -v "$(pwd)"/input:/input lukin0110/up_caffe pose input/debruyne1.jpg
```

### 3. Execute bodyfit

```
$ docker run -it -v "$(pwd)"/input:/input lukin0110/up_caffe bodyfit input/debruyne1.jpg
```

### 4. Execute segmentation

It's required to use [NVIDIA Docker](https://github.com/NVIDIA/nvidia-docker) to
run the segmentation since CUDA is being used.

```
$ nvidia-docker run -it -v "$(pwd)"/input:/input lukin0110/up_deeplab segmentation input/debruyne1.jpg
```

## Setup from source

Before you execute the script: download **SMPL_python_v.1.0.0.zip**
from http://smpl.is.tue.mpg.de/ and put it in the ./models folder. You need an
account to download the package.

```
./prepare.sh
```

Build image:
```
$ docker-compose build
```

Generate pose prediction:
```
$ docker-compose run caffe pose input/debruyne1.jpg
```

This will generate `.npz` and `.png` files in the `input` folder.

Generate 3D body:
```
$ docker-compose run caffe bodyfit input/debruyne1.jpg
```

Generate segmentation:
```
$ nvidia-docker-compose run deeplab segmentation input/debruyne1.jpg
```

Install nvidia docker compose if it is not present yet: `pip install nvidia-docker-compose`.

## Push to docker hub

```
$ docker tag demo2d3d_caffe:latest lukin0110/up_caffe:latest
$ docker tag demo2d3d_deeplab:latest lukin0110/up_deeplab:latest
$ docker push lukin0110/up_caffe:latest
$ docker push lukin0110/up_deeplab:latest
```
