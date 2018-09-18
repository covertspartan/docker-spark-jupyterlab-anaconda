#!/usr/bin/env bash
set -e
if ! [[ -n ${SPARK_USER} ]]; then
    export SPARK_USER="spark"
fi

echo "Setting up user: ${SPARK_USER}"
useradd -ms /bin/bash ${SPARK_USER}

. /opt/conda/etc/profile.d/conda.sh
conda activate base
pwd

mkdir /notebook
export HOME=/notebook
cd ${HOME}

jupyter notebook --generate-config
echo "c.NotebookApp.token = ''" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = '/notebook'" >> .jupyter/jupyter_notebook_config.py

chown ${SPARK_USER} -R ${HOME}
su -p ${SPARK_USER} -c 'jupyter-lab --no-browser'
