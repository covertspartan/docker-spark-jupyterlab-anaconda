FROM cjonesy/docker-spark:latest
MAINTAINER covertspartan

RUN yum install -y bzip2

#-------------------------------------------------------------------------------
# Install Anaconda
#-------------------------------------------------------------------------------
RUN wget --quiet https://repo.continuum.io/archive/Anaconda2-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

#-------------------------------------------------------------------------------
# Expose Jupyter and Spark WebUI default ports
# Setup Python Path Variables
#-------------------------------------------------------------------------------
EXPOSE 4040 8888
ENV SPARK_HOME=/usr/spark
ENV PYTHONPATH=${PYTHONPATH}:/usr/local/sifi/sifi_spark/:${SPARK_HOME}/python/:${SPARK_HOME}/python/lib/:${SPARK_HOME}/python/lib/py4j-0.10.7-src.zip


#-------------------------------------------------------------------------------
# Entry
#-------------------------------------------------------------------------------
COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["sh"]