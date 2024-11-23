#!/bin/bash

set -e

VENV=~/.cache/pypoetry/virtualenvs/niimprint-VR7PZxhu-py3.11
SRC_DIR=~/inventree/inventree-data/media/label/output
SRC_FILE=$(ls -Art ${SRC_DIR} | tail -n 1)
TARGET_FILE=$(mktemp --suffix=.png)
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

source $VENV/bin/activate

magick \
  -density 203 \
  ${SRC_DIR}/${SRC_FILE} \
  -quality 100 \
  -flatten \
  -sharpen 0x1.0 \
  ${TARGET_FILE}

python ${SCRIPT_DIR}/niimprint -i ${TARGET_FILE} -r 90 -d 1 -m d110 -a /dev/ttyACM0

rm ${TARGET_FILE}
