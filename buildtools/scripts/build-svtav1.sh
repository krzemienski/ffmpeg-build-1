#!/bin/bash -x

echo "OSTYPE: $OSTYPE"
if [[ "$OSTYPE" == "darwin"* ]]; then

    realpath() { # there's no realpath command on macosx 
        [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
    }
fi
CURRENT_DIR_PATH=$(dirname $(realpath $0))
PROJECT_ROOT_PATH=${CURRENT_DIR_PATH}/../../


source ${CURRENT_DIR_PATH}/make-parallel-check.sh

# enter build foler
cd ${PROJECT_ROOT_PATH}/SVT-AV1/Build

# build svt-av1
cmake .. -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=${PROJECT_ROOT_PATH}/build -DBUILD_SHARED_LIBS=OFF
make ${MAKE_PARALLEL} && make install

# go back
cd -
