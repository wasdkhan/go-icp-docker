# go-icp-docker
[Go-ICP](http://jlyang.org/go-icp/) is a registration algorithm for 3d point clouds with global optimization. However, it needs nornalized models in txt file format as input. This container with script does pre-processing to normalize (values in \[-1,1\]) any ply files passed as input, generate the registration matrix (GoICP), register the reading model to the reference model, and calculate the error between the two models using [PCL](http://pointclouds.org/).

## To Build from Docker Hub
Pull the [image](https://hub.docker.com/r/wasd/go-icp-docker/) from Docker Hub like so:
```
docker pull wasd/go-icp-docker
```
Skip to running the container after this step

## To Build from Dockerfile
Clone this repository and edit the Dockerfile, if you wish, and then run in the same directory as the Dockerfile:
```
git clone https://github.com/wasdkhan/go-icp-docker
cd go-icp-docker
docker build -t wasd/go-icp-docker .
```

## To Run
Go to your two 3D models folder, let's say it's defined as $MODEL_DIR  
Run either one of the following on the command line  
Without X-forwarding:
```
docker run -it --rm \
  -v $MODEL_DIR:/models/ \
  -w=/root/maya-archaeology/go-icp-script/scripts \
  wasd/go-icp-docker
```
With X-forwarding (to view error models):  
First, Enable non-network local connections to access control list
```
xhost +local:
```
Next, Run the container
```
docker run -it --rm \
  -v $MODEL_DIR:/models/ \
  -w=/root/maya-archaeology/go-icp-script/scripts \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  wasd/go-icp-docker
```
Optionally, after exiting docker container, to bring back to normal:
```
xhost -
```

## To Use
To register two ply files and calculate the error afterwards:
```
python go-icp.py /models/reference.ply /models/reading.ply
```
Results should be printed in console and files will be located in /root/maya-archaeology/go-icp-script/models/reading folder  
Refer to [Documentation](https://github.com/UCSD-E4E/maya-archaeology#go-icp-script) for specifics
```
python error.py /models/reference.(vtk, ply, pcd) /models/reading.(vtk, ply, pcd)
```
Results are stored in /models/e-reading/ folder and has the input files as pcd, the input files with norms as pcd, and the error models in pcd and ply formats.  
Refer to [Errors](https://github.com/UCSD-E4E/maya-archaeology/wiki/4.-Calculating-Error#computing-cloud-errors)
