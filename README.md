# butd-pytorch-docker
Dockerfile for [MILVLG/bottom-up-attention.pytorch](https://github.com/MILVLG/bottom-up-attention.pytorch), a PyTorch reimplementation of the bottom-up-attention project based on Caffe

## Quick start
### Pre-start actions
In order use GPUs inside containers, we'll be using [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker).

Make sure you have installed the NVIDIA driver and Docker 19.03 for your Linux distribution Note that you do not need to install the CUDA toolkit on the host, but the driver needs to be installed.

For more infomation, please visit [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker) official repository.

### Pull or Build the image
To  image, you can directly pull from [Dockerhub](https://hub.docker.com)[recommended] or build from the local environment.

#### To Pull
`docker pull denton35/butd-pytorch-docker`

will pull the latest image from dockerhub. Use `sudo` if needed.

#### To Build
`git clone https://github.com/HyperDenton/butd-pytorch-docker`
`cd butd-pytorch-docker`
`docker build .`

### Try the image
`sudo docker run --rm -it denton35/butd-pytorch-docker`
