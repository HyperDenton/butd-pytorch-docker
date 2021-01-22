FROM nvidia/cuda:10.1-cudnn7-devel

# install python
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	python3-opencv ca-certificates python3-dev python3-pip git wget sudo  \
	cmake ninja-build protobuf-compiler libprotobuf-dev && \
  rm -rf /var/lib/apt/lists/*
RUN ln -sv /usr/bin/python3 /usr/bin/python

# install detectron2
RUN pip3 install tensorboard
RUN pip3 install torch==1.5 torchvision==0.6 -f https://download.pytorch.org/whl/cu101/torch_stable.html
RUN pip3 install 'git+https://github.com/facebookresearch/fvcore'

RUN mkdir /workspace
RUN git clone https://github.com/facebookresearch/detectron2 /workspace/detectron2
RUN cd /workspace/detectron2 && git reset --hard be792b959bca9af0aacfa04799537856c7a92802 && cd /workspace
ENV FORCE_CUDA="1"
ARG TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"
RUN pip3 install -e /workspace/detectron2

# install apex
RUN cd /workspace && \
    git clone https://github.com/NVIDIA/apex.git && \
    cd apex && \
    python setup.py install
    
# clone and install, see https://github.com/MILVLG/bottom-up-attention.pytorch
RUN pip3 install wget
RUN pip3 install streamlit
RUN pip3 install ray
RUN apt install ffmpeg libsm6 libxext6 -y

RUN cd /workspace && \
    git clone https://github.com/MILVLG/bottom-up-attention.pytorch && \
    cd bottom-up-attention.pytorch && \
    python setup.py build develop

WORKDIR /workspace/bottom-up-attention.pytorch
