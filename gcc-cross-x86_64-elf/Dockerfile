# Docker image for cross-compiler with specified target
# Instructions for building from source taken from https://wiki.osdev.org/GCC_Cross-Compiler

FROM debian:latest AS build

ENV BINUTILS_VERSION=2.41
ENV GDB_VERSION=13.2
ENV GCC_VERSION=13.2.0
ENV TARGET=x86_64-elf
ENV PREFIX=/usr/local
ENV SRC_DIR=/usr/local/src
ENV BUILD_DEPS='build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo wget'

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y ${BUILD_DEPS}

RUN mkdir -p ${SRC_DIR}

WORKDIR ${SRC_DIR}
RUN wget -q https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.gz
RUN tar -zxf binutils-${BINUTILS_VERSION}.tar.gz --no-same-owner --no-same-permissions
RUN rm -f binutils-${BINUTILS_VERSION}.tar.gz
RUN mkdir build-binutils

WORKDIR ${SRC_DIR}/build-binutils
RUN ../binutils-${BINUTILS_VERSION}/configure --target=${TARGET} --prefix=${PREFIX} --with-sysroot --disable-nls --disable-werror
RUN make
RUN make install

WORKDIR ${SRC_DIR}
RUN wget -q https://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.gz
RUN tar -zxf gdb-${GDB_VERSION}.tar.gz --no-same-owner --no-same-permissions
RUN rm -f gdb-${GDB_VERSION}.tar.gz
RUN mkdir build-gdb

WORKDIR ${SRC_DIR}/build-gdb
RUN ../gdb-${GDB_VERSION}/configure --target=${TARGET} --prefix=${PREFIX} --disable-werror
RUN make all-gdb
RUN make install-gdb

WORKDIR ${SRC_DIR}
RUN wget -q https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz
RUN tar -zxf gcc-${GCC_VERSION}.tar.gz --no-same-owner --no-same-permissions
RUN rm -f gcc-${GCC_VERSION}.tar.gz
RUN mkdir build-gcc

WORKDIR ${SRC_DIR}/build-gcc
RUN ../gcc-${GCC_VERSION}/configure --target=${TARGET} --prefix=${PREFIX} --disable-nls --enable-languages=c,c++ --without-headers
RUN make all-gcc
RUN make all-target-libgcc
RUN make install-gcc
RUN make install-target-libgcc

WORKDIR /
RUN rm -rf ${SRC_DIR}

FROM debian:latest
COPY --from=build /usr/local /usr/local
