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
