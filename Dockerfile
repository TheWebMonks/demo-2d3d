#
# All-in-one Docker image
#
FROM floydhub/dl-docker:cpu

ENV DEBIAN_FRONTEND=noninteractive
ENV BASE=/code/up-master

# Create code dir an download UP
# https://github.com/classner/up
RUN mkdir /code
WORKDIR /code
RUN apt-get install realpath \
    && wget https://github.com/classner/up/archive/master.zip \
    && unzip master.zip \
    && rm master.zip
WORKDIR ${BASE}

# Install python packages
RUN pip install -r ${BASE}/requirements.txt

# Adding Caffemodels
ADD models/test2.caffemodel ${BASE}/pose/training/model/pose/


