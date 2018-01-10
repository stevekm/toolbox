#!/bin/bash
# start Jupyer Notebook Docker
docker run --privileged --rm -it -p 8888:8888 -v "$(pwd):/home/jovyan" jupyter/datascience-notebook
