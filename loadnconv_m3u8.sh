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
SEGMENT_URLS=$(curl -s -S ${URL} | grep -v "^#")

for SEG_URL in ${SEGMENT_URLS}; do
    echo "loading segment: ${SEG_URL} ..."
    curl -s -S -o segment.ts ${SEG_URL}
    cat segment.ts >> raw.ts
    rm segment.ts
done

./convert.sh raw.ts ${TARGET}
