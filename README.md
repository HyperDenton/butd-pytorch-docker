# butd-pytorch-docker
Dockerfile for [MILVLG/bottom-up-attention.pytorch](https://github.com/MILVLG/bottom-up-attention.pytorch), a PyTorch reimplementation of the bottom-up-attention project based on Caffe

## Quick start
### Pre-start actions
In order use GPUs inside containers, we'll be using [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker).

Make sure you have installed the NVIDIA driver and Docker 19.03 for your Linux distribution Note that you do not need to install the CUDA toolkit on the host, but the driver needs to be installed.

For more information, please visit [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker) official repository.

### Pull or Build the image
To  image, you can directly pull from [Dockerhub](https://hub.docker.com)[recommended] or build from the local environment.

#### To Pull
`docker pull denton35/butd-pytorch-docker`

will pull the latest image from dockerhub. Use `sudo` if needed.

#### To Build
Pull the Dockerfile:
`git clone https://github.com/HyperDenton/butd-pytorch-docker`

Goto the repo directory:
`cd butd-pytorch-docker`

Build the image:
`docker build .`

### Try the image
Start the image and enter the image `bash`:
`sudo docker run --gpus all --rm -it denton35/butd-pytorch-docker`

in which

`--gpus all` to enable [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker);

`--rm` to remove the image after use;

`-it` to enter the image `bash`.

For more usage of Docker, please visit [Docker Reference Page](https://docs.docker.com/engine/reference/builder/).

### FAQ
#### `docker pull` too slow
Consider using docker accelerator:

  ```bash
  sudo mkdir -p /etc/docker
  sudo tee /etc/docker/daemon.json <<-'EOF'
  {
    "registry-mirrors": ["https://****.****.****.com"]
  }
  EOF
  sudo systemctl daemon-reload
  sudo systemctl restart docker
  ```
where `https://****.****.****.com` is your address of your accelerator.

To get address accelerator, you might need to register to the docker accelerator service provider, e.g. [Aliyun](https://cr.console.aliyun.com/#/accelerator)
