# GCC 13.2 cross-compiler

This is a cross-compiler for the 'TARGET' target system.

Images have been built for the following platforms: PLATFORMS.

The source material is available in [GitHub](https://github.com/techiekeith/osdev) under the `gcc-cross-compiler` folder.

> In order to control the image size, this image does not contain any of the dependencies required to build GCC itself. You'll need to (re)install those dependencies yourself if you need them.

## Example usage

*buildenv/Dockerfile*
```dockerfile
FROM USER/gcc-cross-TARGET-elf

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential nasm xorriso grub-pc-bin grub-common

VOLUME /root/env
WORKDIR /root/env
```

*CLI (bash)*
```shell
docker build buildenv/TARGET -t USER/osdev-buildenv-TARGET
docker run --rm -it -v $(pwd):/root/env USER/osdev-buildenv-TARGET make build-TARGET
```

*CLI (PowerShell)*
```powershell
docker build buildenv/TARGET -t USER/osdev-buildenv-TARGET
docker run --rm -it -v "$($(pwd).Path):/root/env" USER/osdev-buildenv-TARGET make build-TARGET
```
