#!/bin/bash
docker run -d -p 8888:8888 \
--user root -e GRANT_SUDO=yes \
-v $(pwd):/home/jovyan/work \
jupyter/datascience-notebook start-notebook.sh --NotebookApp.token='sha1:ef32e09de243:e62e989f13b071cdf2558425c3838916cce6a5c4'
