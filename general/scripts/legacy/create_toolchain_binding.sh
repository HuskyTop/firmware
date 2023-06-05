#!/bin/bash

TOOLCHAIN_DIR=$1
TOOLCHAIN_PREFIX=$2

cat - << EOF
# THIS FILE IS GENERATED BY $(readlink -f $0)

TOOLCHAIN_DIR     := $TOOLCHAIN_DIR
TOOLCHAIN_PREFIX  := $TOOLCHAIN_PREFIX

TOOLCHAIN := \$(TOOLCHAIN_DIR)/\$(TOOLCHAIN_PREFIX)

CC := \$(TOOLCHAIN)-gcc
AR := \$(TOOLCHAIN)-ar
LD := \$(TOOLCHAIN)-ld
RANLIB := \$(TOOLCHAIN)-ranlib
NM := \$(TOOLCHAIN)-nm
STRIP := \$(TOOLCHAIN)-strip
EOF

EXTRA_BINS=(go gofmt m4 swig)

for I in ${EXTRA_BINS[*]}; do
    if [ -e $TOOLCHAIN_DIR/$I ]; then
        echo "${I^^} := \$(TOOLCHAIN_DIR)/$I"
    fi
done