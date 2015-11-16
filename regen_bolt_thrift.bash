#!/bin/bash --login
set -e

ROOT=$(git rev-parse --show-toplevel)
BOLT_THRIFT=$1

if [[ ${BOLT_THRIFT} == '' ]]; then
    echo "Please specify the bolt.thrift file as first argument"
    exit 1
fi

if [[ $(which thrift) != '' ]]; then
    rm -rf ${ROOT}/lib/gen-rb
    thrift --gen rb -o ${ROOT}/lib $BOLT_THRIFT
    echo "DONE!"
else
    echo "Sorry you don't have apache thrift installed"
    exit 1
fi
