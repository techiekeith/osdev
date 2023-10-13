#!/bin/sh

docker build buildenv/i686 -t techiekeith/osdev-buildenv-i686
docker build buildenv/x86_64 -t techiekeith/osdev-buildenv-x86_64
