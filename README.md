# OS Development playground

## The cross-compiler

Latest images are publicly available from [Docker Hub](https://hub.docker.com/u/techiekeith). If you prefer to build one yourself, the `gcc-cross-compiler` folder contains all the assets needed to do that.

## Create the build environment

```
scripts/docker_build.{bat,ps1,sh}
```

## Build the ISO

```
scripts/build.{bat,ps1,sh}
```

## Run the OS

```
scripts/run.{bat,ps1,sh}
```

### On success

* (i686) The letters 'OK' will show on a green background in the top left corner of the screen.
* (x86_64) The words 'Welcome to our 64-bit kernel!' will show in yellow text at the top of the screen.

## References

* [OSDev.org](https://wiki.osdev.org/Main_Page) - far and away the most important resource for OS development
* [CodePulse - Write Your Own 64-bit Operating System Kernel From Scratch](https://www.youtube.com/playlist?list=PLZQftyCk7_SeZRitx5MjBKzTtvk0pHMtp)
  * This tutorial only lasted a couple of episodes, enough to jump to long mode and write to the screen in VGA 80x25 16-color text mode
