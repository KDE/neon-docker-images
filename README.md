# KDE neon Docker images - Plasma

Updated daily with the latest from KDE neon, itself automatically updated with the latest KDE software.

## Running

Best run from the neondocker script:
https://community.kde.org/Neon/Docker

Images are stored in the registry at `invent-registry.kde.org/neon/docker-images/`

Flavours available are: `plasma:unstable`, `plasma:testing`, `plasma:user`, `plasma:plasma`

For flavours with all applications installed see `all`.

By default it will run a full session with startkde on DISPLAY=:1, you can use Xephyr as an X server window.

```
Xephyr -screen 1024x768 :1 &
docker run --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --network=host -v /tmp/.X11-unix:/tmp/.X11-unix invent-registry.kde.org/neon/docker-images/plasma:unstable
```

Or you can tell it to run on DISPLAY=:0 and run a single app

```
docker run --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --network=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=:0 --security-opt seccomp=unconfined invent-registry.kde.org/neon/docker-images/plasma:unstable dolphin
```

Or use the `neondocker` script.
