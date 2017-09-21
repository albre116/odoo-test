#!/bin/bash
docker run -d -p 8888:8888 \
--user root -e GRANT_SUDO=yes \
-v $(pwd):/home/jovyan/work \
jupyter/datascience-notebook start-notebook.sh --NotebookApp.token='EzAce'
