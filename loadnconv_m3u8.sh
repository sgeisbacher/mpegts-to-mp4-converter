#!/bin/bash

set -e

URL=${1}
TARGET=${2}

if [ "${URL}" == "" ]; then
    echo "m3u8-url is mandatory"
    exit 1
fi

if [ "${TARGET}" == "" ]; then
    echo "target is mandatory"
    exit 1
fi

echo "loading m3u8-file ..."
SEGMENT_URLS=$(curl -s -S --retry 3 --retry-delay 5 ${URL} | grep -v "^#")

for SEG_URL in ${SEGMENT_URLS}; do
    echo "loading segment: ${SEG_URL} ..."
    for i in $(seq 1 3); do
        curl -s -S --retry-connrefused --retry 3 --retry-delay 5 -o segment.ts ${SEG_URL} && break || sleep 5
	echo "retrying ..."
    done

    if [ ! -f segment.ts ]; then
        echo "could not load ${SEG_URL}, aborting ..."
        exit 2
    fi
    
    cat segment.ts >> raw.ts
    rm segment.ts
done

./convert.sh raw.ts ${TARGET}
