#!/bin/sh

arg=$1
Target=${1}-elf
if [ "$Target" != "i686-elf" -a "$Target" != "x86_64-elf" ]; then
    echo "Usage: $0 [i686 | x86_64] (provided: '$arg')"
    exit 1
fi

docker_user='techiekeith'
Platforms=("linux/amd64" "linux/arm64")

docker buildx build \
    --build-arg TARGET=${Target} \
    --platform $(IFS=, ; echo "${Platforms[*]}") \
    . \
    --push \
    -t techiekeith/gcc-cross-${Target}

mkdir -p generated-docs
plist2=$(printf ", %s" "${Platforms[@]}")
plist2=${plist2:2}
cat docker-hub-overview-template.md \
    | sed "s/TARGET/$arg/g" \
    | sed "s/USER/$docker_user/g" \
    | sed "s/PLATFORMS/$plist2/g" \
    > generated-docs/docker-hub-overview-${arg}.md

echo "Copy the contents of generated-docs/docker-hub-overview-${arg}.md"
echo "to the Overview section in Docker Hub:"
echo "https://hub.docker.com/repository/docker/techiekeith/gcc-cross-${arg}-elf/general"
