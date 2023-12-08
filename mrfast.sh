set -e

# Check if the mrfast docker image has not yet been built.
if ! docker images | grep -E '^mrfast\b'; then
	# Build the mrfast docker image for the first time.
	pushd "$(dirname "$0")" >/dev/null
	docker build --platform linux/x86_64 -t mrfast:latest -f docker/local.Dockerfile .
	popd >/dev/null
fi

# Run mrfast within a transient docker container.
# The current directory will be accessible from within the container.
docker run --platform linux/x86_64 --rm --mount=type=bind,source=.,target=/home mrfast "$@"
