docker run --rm -it -v "$($(pwd).Path):/root/env" techiekeith/osdev-buildenv-i686 make build -e TARGET=i686
docker run --rm -it -v "$($(pwd).Path):/root/env" techiekeith/osdev-buildenv-x86_64 make build -e TARGET=x86_64
