# arm-buildpacks

Prep folders
```
mkdir platform
mkdir buildpacks
mkdir apps
```

Clone samples - optional
```
git clone https://github.com/buildpacks/samples
```

Clone buildpacks
```
git clone git@github.com:paketo-buildpacks/node-engine.git buildpacks/paketo-buildpacks_node-engine/
git clone git@github.com:paketo-buildpacks/npm-start.git buildpacks/paketo-buildpacks_npm-start/
git clone git@github.com:paketo-buildpacks/npm-install.git buildpacks/paketo-buildpacks_npm-install/
```

Clone apps
```
git clone git@github.com:gimlet-io/expressjs-test-app.git apps/expressjs-test-app
git clone git@github.com:gimlet-io/reactjs-test-app.git apps/reactjs-test-app
```

Clone lifecycler

```
rm -rf lifecycle*
export RELEASE_VERSION=v0.16.5
curl -L https://github.com/buildpacks/lifecycle/releases/download/$RELEASE_VERSION/lifecycle-$RELEASE_VERSION+linux.arm64.tgz | tar xfz -
mv lifecycle lifecycle-arm64
curl -L https://github.com/buildpacks/lifecycle/releases/download/$RELEASE_VERSION/lifecycle-$RELEASE_VERSION+linux.x86-64.tgz | tar xfz -
mv lifecycle lifecycle-x86-64
rm lifecycle.toml
```

Build stack images

```
cd stacks/jammy/base
docker build -t jammy-base .
docker build -f Dockerfile.arm -t jammy-base .

cd stacks/jammy/build
docker build -t jammy-build --build-arg base_image=jammy-base --build-arg stack_id=io.buildpacks.stacks.jammy .

cd stacks/jammy/run
docker build -t jammy-run --build-arg base_image=jammy-base --build-arg stack_id=io.buildpacks.stacks.jammy .
```

Build buildpacks
```
cd buildpacks/paketo-buildpacks_node-engine
./scripts/build.sh

cd buildpacks/paketo-buildpacks_npm-install
./scripts/build.sh

cd buildpacks/paketo-buildpacks_npm-start
./scripts/build.sh
```

Build images

```
sh pack-expressjs.sh
docker run -p 3000:3000 -it --rm expressjs
```


```
sh pack-reactjs.sh
docker run -p 3000:3000 -it --rm reactjs
```

