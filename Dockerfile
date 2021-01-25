FROM nvidia/cuda:10.1-cudnn7-devel

# install python
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	python3-opencv ca-certificates python3-dev python3-pip git wget sudo  \
	cmake ninja-build protobuf-compiler libprotobuf-dev && \
  rm -rf /var/lib/apt/lists/*
RUN ln -sv /usr/bin/python3 /usr/bin/python

# install detectron2
RUN pip3 --no-cache-dir install tensorboard
RUN pip3 --no-cache-dir install torch==1.5 torchvision==0.6 -f https://download.pytorch.org/whl/cu101/torch_stable.html
RUN pip3 --no-cache-dir install 'git+https://github.com/facebookresearch/fvcore'

RUN pip3 install scikit-build
RUN pip3 install opencv-python
RUN pip3 install cython
RUN pip3 install "git+https://github.com/philferriere/cocoapi.git#egg=pycocotools&subdirectory=PythonAPI"
RUN pip3 install 'git+https://github.com/facebookresearch/detectron2.git@be792b959bca9af0aacfa04799537856c7a92802'

# install apex
RUN cd /workspace && \
    git clone https://github.com/NVIDIA/apex.git && \
    cd apex && \
    python setup.py install
    
# clone and install, see https://github.com/MILVLG/bottom-up-attention.pytorch
RUN pip3 install wget
RUN pip3 install streamlit
RUN pip3 install ray

RUN cd /workspace && \
    git clone https://github.com/MILVLG/bottom-up-attention.pytorch && \
    cd bottom-up-attention.pytorch && \
    python setup.py build develop

WORKDIR /workspace/bottom-up-attention.pytorch
