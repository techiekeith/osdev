# OS Development playground

## References

* [OSDev.org](https://wiki.osdev.org/Main_Page)
* [CodePulse - Write Your Own 64-bit Operating System Kernel From Scratch](https://www.youtube.com/playlist?list=PLZQftyCk7_SeZRitx5MjBKzTtvk0pHMtp)

## Cross-compiler

### Build (takes around 30 minutes on a Ryzen 5600X)

```pwsh
docker build gcc-cross-x86_64-elf -t techiekeith/gcc-cross-x86_64-elf
docker push techiekeith/gcc-cross-x86_64-elf
```

### Public repository

https://hub.docker.com/r/techiekeith/gcc-cross-x86_64-elf

## Build rest of build environment

```pwsh
docker build buildenv -t techiekeith/osdev-buildenv
```

## Build ISO

### Windows PowerShell

```pwsh
docker run --rm -it -v "$($(pwd).Path):/root/env" techiekeith/osdev-buildenv make build-x86_64
& 'C:\Program Files\qemu\qemu-system-x86_64.exe' -cdrom dist/x86_64/kernel.iso
```

### Linux / macOS

```bash
docker run --rm -it -v $(pwd):/root/env myos-buildenv make build-x86_64
qemu-system-x86_64 -cdrom dist/x86_64/kernel.iso
```
