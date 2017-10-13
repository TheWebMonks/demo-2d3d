# All-in-one Docker image
FROM floydhub/dl-docker:cpu

ENV DEBIAN_FRONTEND=noninteractive
ENV BASE=/code/up-master

# Create code dir an download UP
# https://github.com/classner/up
RUN mkdir /code
WORKDIR /code
COPY deployment/requirements.txt .
RUN apt-get install realpath \
    && wget https://github.com/classner/up/archive/master.zip \
    && unzip master.zip \
    && rm master.zip
WORKDIR ${BASE}

# Install python packages
RUN pip install -r ${BASE}/requirements.txt
RUN pip install -r /code/requirements.txt

# Adding Caffemodels
ADD models/test2.caffemodel ${BASE}/pose/training/model/pose/

# Add the entrypoint.sh
COPY deployment/docker-entrypoint.sh /usr/local/bin/
RUN chmod ugo+x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/bash", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["bash"]
