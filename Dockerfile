# All-in-one Docker image
FROM floydhub/dl-docker:cpu

ENV DEBIAN_FRONTEND=noninteractive
ENV BASE=/code/up
ARG COMMIT_HASH_UP=bf67bc4a1e488b3b0e35f43dfd602b7225a03641

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        realpath \
        unzip && \
    rm -rf /var/lib/apt/lists/*

# Create code dir an download UP
# https://github.com/classner/up
RUN mkdir /code
WORKDIR /code
COPY deployment/requirements.txt .
RUN wget https://github.com/classner/up/archive/${COMMIT_HASH_UP}.zip \
    && unzip ${COMMIT_HASH_UP}.zip \
    && mv up-${COMMIT_HASH_UP} up/ \
    && rm ${COMMIT_HASH_UP}.zip
WORKDIR ${BASE}

# Install python packages
RUN pip install -r /code/requirements.txt

# Adding models: caffe & smpl
COPY models /models/
RUN cd /models \
    && mkdir -p ${BASE}/pose/training/model/pose/ \
    && unzip p91.zip -d ${BASE}/pose/training/model/pose/ \
    && unzip SMPL_python_v.1.0.0.zip \
    && mv -v smpl/* /usr/lib/python2.7/dist-packages/ \
    && rm *.zip

# Add the entrypoint.sh
COPY deployment/docker-entrypoint.sh /usr/local/bin/
RUN chmod ugo+x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/bash", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["bash"]
