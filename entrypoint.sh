#!/usr/bin/env bash
set -e

# Ensure that we don't run as root.
if ! [[ -n ${SPARK_USER} ]]; then
    export SPARK_USER="spark"
fi

echo "Setting up user: ${SPARK_USER}"
useradd -ms /bin/bash ${SPARK_USER}

# create conda environment
. /opt/conda/etc/profile.d/conda.sh
conda activate base
pwd

# create notebook root
mkdir /notebook
export HOME=/notebook
cd ${HOME}

# setup notebook server... currently using no token
jupyter notebook --generate-config
echo "c.NotebookApp.token = ''" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = '/notebook'" >> .jupyter/jupyter_notebook_config.py

chown ${SPARK_USER} -R ${HOME}

# Install optional pip dependencies
if [[ -n ${PIP_DEPENDENCIES} ]]; then
    su -p ${SPARK_USER} -c "pip install ${PIP_DEPENDENCIES} --user"
fi

# Fire up notebook server
su -p ${SPARK_USER} -c 'jupyter-lab --no-browser'
