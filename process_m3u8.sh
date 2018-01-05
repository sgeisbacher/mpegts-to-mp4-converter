#!/bin/bash

set -e

DOCKER_IMAGE="mpegts-to-mp4-converter"

M3U8_URL=$1
TARGET=$2

if [ "${M3U8_URL}" == "" ]; then
    echo "M3U8_URL is mandatory"
    exit 1
fi

if [ "${TARGET}" == "" ]; then
    echo "TARGET is mandatory"
    exit 1
fi

docker build -t ${DOCKER_IMAGE} . 

CONTAINER_ID=$(docker run -d ${DOCKER_IMAGE} ./loadnconv_m3u8.sh ${M3U8_URL} /output.mp4)
docker logs -f ${CONTAINER_ID}
docker cp ${CONTAINER_ID}:/output.mp4 ${TARGET}
docker rm -f ${CONTAINER_ID}
