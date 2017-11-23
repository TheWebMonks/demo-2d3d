# All-in-one Docker image
FROM floydhub/dl-docker:cpu

ENV DEBIAN_FRONTEND=noninteractive
ENV BASE=/code/up
ENV COMMIT=bf67bc4a1e488b3b0e35f43dfd602b7225a03641

# Create code dir an download UP
# https://github.com/classner/up
RUN mkdir /code
WORKDIR /code
COPY deployment/requirements.txt .
RUN apt-get install -y realpath git \
    && wget https://github.com/classner/up/archive/${COMMIT}.zip \
    && unzip ${COMMIT}.zip \
    && mv up-${COMMIT} up/ \
    && rm ${COMMIT}.zip
WORKDIR ${BASE}

# Install python packages
RUN pip install -r ${BASE}/requirements.txt
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
