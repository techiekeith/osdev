# GCC Cross-compiler

The latest images are publicly available from [Docker Hub](https://hub.docker.com/u/techiekeith) ([i686](https://hub.docker.com/r/techiekeith/gcc-cross-i686-elf) | [x86_64](https://hub.docker.com/r/techiekeith/gcc-cross-x86_64-elf)).

## Building in PowerShell

### Setting up `docker buildx`

```powershell
buildx_setup.ps1
```

### Building and publishing a new image

```powershell
publish.ps1 i686
publish.ps1 x86_64
```
### Cleaning up

```powershell
buildx_teardown.ps1
```

### Generated documents

The build and publish process also generates documents in the `generated-docs` folder, suitable for
repository documentation. The template is at `docker-hub-overview-template.md`.
