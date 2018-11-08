# docker-spark-jupyterlab-anaconda
Dockerhub image with spark and anaconda preinstalled, for launching spark jobs from notebooks.

The end user is expected to mount their spark-configs in `/usr/spark/conf`

You may build and run the image locally with the following command from within the root project directory:
```
docker build . --tag spark-jupyter-local-test
docker run -i -t -p 8888:8888 -P spark-jupyter-local-test:latest
```

Additional packages may be automatically installed when the notebook starts by defining the `PIP_DEPENDENCIES`