# A Dockerised storm-extract

[storm-extract](https://github.com/nydus/storm-extract) is a command line tool to extract Heroes Of The Storm game files.

This project aims to create a prebuilt docker image with the necessary binary installed. This can remove the hassle to build `storm-extract` manually (and also cross platform!) 

The final built image is ~1.52MB download and ~3.43 MB when extracted. It also does not contain any OS component so running this image is very fast and close to native speed.

# Prerequisite

Having Docker installed and running on the your system. 

> [Install Docker](https://www.docker.com/) if you not have done so.

# Usage

To run the command:

```bash
docker run \
   -it --init \
   -v "path/to/install:/input" \
   -v "path/to/output:/output" \
   jamiephan/storm-extract-docker
```

The image will look for two paths:

 - `/input`: The installation of Heroes of the Storm
 - `/output`: The output files for extraction

 You can mount the volume to your local disk by using `-v` switch.

 For example:

 - Heroes of the Storm install location: `/mnt/c/Program Files/Heroes of the Storm`
 - Extraction output: `/mnt/d/HeroesFiles`

 The command will be:

```bash
docker run \
   -it --init \
   -v "/mnt/c/Program Files/Heroes of the Storm:/input" \
   -v "/mnt/d/HeroesFiles:/output" \
   jamiephan/storm-extract-docker
```

> Note: `-it --init` is a workaround for Ctrl+C interrupt. Since there are some weird stuff will happen in PID 1 for containers. If you do not need Ctrl+C interrupt, this line is not needed but you will lose the ability to stop the command with Ctrl+C. (You can still manually stop the container with `docker stop`.)


## The `storm-extract` command-line options

You can append any command line options from [storm-extract](https://github.com/nydus/storm-extract). However, **DO NOT**(!) add the following switches:

- `-x`, `--extract`
- `-o`, `--out`
- `-i`, `--in`

> WARN: The Image does not check whether you have passed in these command line switch. If you done so, weird stuff might happen.

> //TODO Add an entrypoint script to check the passed in params.


For example to also print verbosely and search for *.xml files, you can do:

```bash
docker run \
   -it --init \
   -v "path/to/install:/input" \
   -v "path/to/output:/output" \
   jamiephan/storm-extract-docker --verbose --filetype xml
```

# Tips

If you use this command regularly and the Heroes of the Storm installation as well as the output directory won't change a lot, you can consider to alias the command.

This allows a simple `storm-extract` command to replace the gigantic docker run string. Which allows it to behave like a normal command, e.g `storm-extract --verbose --filetype xml`

#### Linux
Edit and append the following line in `~/.bashrc`:

```bash
alias storm-extract='docker run -it --init -v "/path/to/install:/input" -v "/path/to/output:/output" jamiephan/storm-extract-docker'
```
>Note: Remember to change `/path/to/install` and `/path/to/output`.

Restart the Shell session.

#### Windows

Create a `storm-extract.bat` file with the following content and place the file in any location within the `PATH` Environment Variable, e.g `C:\Windows\System32`.

```bat
@echo off
docker run -it --init -v "/path/to/install:/input" -v "/path/to/output:/output" jamiephan/storm-extract-docker %*
```
>Note: Remember to change `/path/to/install` and `/path/to/output`.

Restart all terminal applications, e.g `cmd.exe`

