docker run --rm \
  --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
  --volume $(pwd)/lifecycle-arm64:/cnb/lifecycle \
  --volume $(pwd)/buildpacks:/cnb/buildpacks \
  --volume $(pwd)/apps/reactjs-test-app:/workspace \
  --volume $(pwd)/platform:/platform \
  --mount type=bind,source=$(pwd)/order.toml,target=/cnb/order.toml \
  --env CNB_PLATFORM_API=0.7 \
  jammy-build \
  /cnb/lifecycle/creator -log-level debug -daemon -layers /home/cnb/layers -run-image jammy-run reactjs
