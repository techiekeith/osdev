$ARM_REMOTE = $true
$ARM_USER = 'keith'
$ARM_HOST = 'dhcp15'

$X86_REMOTE = $false
$X86_USER = 'keith'
$X86_HOST = 'pc'

if ( $X86_REMOTE -eq $true )
{
    docker buildx create `
    --name crossplatform `
    --platform linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/i386 `
    ssh://${X86_USER}@${X86_HOST} `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000
}
else
{
    docker context create --from default node-x86
    docker buildx create `
    --name crossplatform `
    --platform linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/i386 `
    node-x86 `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000
}

if ( $ARM_REMOTE -eq $true )
{
    docker buildx create `
    --name crossplatform `
    --append `
    --platform linux/arm64,linux/arm/v7,linux/arm/v6 `
    ssh://${ARM_USER}@${ARM_HOST} `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000
}
else
{
    docker context create --from default node-arm
    docker buildx create `
    --name crossplatform `
    --append `
    --platform linux/arm64,linux/arm/v7,linux/arm/v6 `
    node-arm `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 `
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000
}

# docker context create --from default node-misc
# docker buildx create `
#   --name crossplatform `
#   --platform linux/riscv64,linux/ppc64le,linux/s390x,linux/mips64le,linux/mips64 `
#   node-misc `
#   --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 `
#   --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000

docker buildx use crossplatform
