# go-icp-docker
Build [Go-ICP](http://jlyang.org/go-icp/) in a Docker container starting from Ubuntu 14.04.

##To build from Docker Hub
Pull the [image](https://hub.docker.com/r/wasd/go-icp-docker/) from Docker Hub like so:
```
$ docker pull wasd/go-icp-docker
```
After doing this, go ahead and skip to running the Docker container.

##To run
Go to your two 3D models folder, let's say it's defined as $MODEL_DIR
Run the following on the command line:
```
$ docker run -it --rm -v $MODEL_DIR:/models/ -w=~/maya-archaeology/go-icp-script/scripts wasd/go-icp-docker 
```

##To use
Refer to [Documentation](https://github.com/UCSD-E4E/maya-archaeology#go-icp-script)
