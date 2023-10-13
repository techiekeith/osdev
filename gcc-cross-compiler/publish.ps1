$arg = $args[0]
$Target = "${arg}-elf"
if ( "$Target" -ne "i686-elf" -and "$Target" -ne "x86_64-elf" )
{
    Write-Output "Usage: $($MyInvocation.MyCommand.Name) [i686 | x86_64] (provided: '$arg')"
    exit 1
}

$docker_user = 'techiekeith'
$Platforms = @( "linux/amd64", "linux/arm64" )

docker buildx build `
    --build-arg TARGET=${Target} `
    --platform $($Platforms -join ',') `
    . `
    --push `
    -t ${docker_user}/gcc-cross-${Target}

New-Item -Type Directory -Force -Name generated-docs
(Get-Content docker-hub-overview-template.md) `
    -creplace "TARGET", ${arg} `
    -creplace "USER", ${docker_user} `
    -creplace "PLATFORMS", $($Platforms -join ', ') `
    > generated-docs/docker-hub-overview-${arg}.md

Write-Output "Copy the contents of generated-docs/docker-hub-overview-${arg}.md"
Write-Output "to the Overview section in Docker Hub:"
Write-Output "https://hub.docker.com/repository/docker/techiekeith/gcc-cross-${arg}-elf/general"
