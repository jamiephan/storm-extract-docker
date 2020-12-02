# A Dockerised storm-extract

[storm-extract](https://github.com/nydus/storm-extract) is a command line tool to extract Heroes Of The Storm game files. This repo aims to containerise the process of the image to have storm-extract running.

# Prerequisite

Having Docker installed and running on the your system. 

> [Install Docker](https://www.docker.com/) if you not have done so.

# Get the image

You can either build the image yourself of from a pre-built image from Dockerhub.

Get the image from Dockerhub

1. Pull the image from Dockerhub

> Note: Not exist yet, so please build the image yourself by now.
```bash
docker pull jamiephan/storm-extract-docker
```

Or to build the image your own:

1. Clone this repo

```bash
git clone https://github.com/jamiephan/storm-extract-docker.git
```

2. Build the image

```bash
docker build storm-extract-docker -t storm-extract-docker
```

# Usage

```bash
docker run \
   --mount type=bind,source="path/to/install",target=/input \
   --mount type=bind,source="path/to/output",target=/output \
   -it --init \ 
   storm-extract-docker
```

#### Whereas:

- `path/to/install` is the installation path of Heroes Of the Storm.

- `path/to/output` is the location where the extract files will go.

- `-it --init` is a workaround for Ctrl+C interrupt. Since there are some weird stuff will happen in PID 1 for containers. If you do not need Ctrl+C interrupt, this line is not needed but you will lose the ability to stop the command with Ctrl+C. (You can still manually stop the container with `docker stop`.)

- `storm-extract-docker` is the tag name for the image. If you build the image yourself, it is the name after `-t` but if you pulled from DockerHub shown above, it should be `jamiephan/storm-extract-docker` instead.

#### `storm-extract` command-line options

You can append any command line options from [storm-extract](https://github.com/nydus/storm-extract) **except**(!) for the followings:

- `-x`, `--extract`
- `-o`, `--out`
- `-i`, `--in`

For example to also print verbosely and search for *.xml files, you can do:

```bash
docker run \
   --mount type=bind,source="path/to/install",target=/input \
   --mount type=bind,source="path/to/output",target=/output \
   -it --init \ 
   storm-extract-docker --verbose --filetype xml
```

# Tips

If you use this command regularly and the Heroes of the Storm installation as well as the output directory won't change a lot, you can consider to alias the command.

This allows a simple `storm-extract` command to replace the gigantic docker run string. Which allows it to behave like a normal command, e.g `storm-extract --verbose --filetype xml`

#### Linux
Edit and append the following line in `~/.bashrc`:

```bash
alias storm-extract='docker run --mount type=bind,source="/path/to/install",target=/input --mount type=bind,source="/path/to/output",target=/output -it --init storm-extract-docker'
```
>Note: Remember to change `/path/to/install` and `/path/to/output`.

Restart the Shell session.

#### Windows

Create a `storm-extract.bat` file with the following content and place the file in any location within the `PATH` Environment Variable, e.g `C:\Windows\System32`.

```bat
@echo off
docker run --mount type=bind,source="/path/to/install",target=/input --mount type=bind,source="/path/to/output",target=/output -it --init storm-extract-docker %*
```
>Note: Remember to change `/path/to/install` and `/path/to/output`.

Restart all terminal applications, e.g `cmd.exe`

