FROM nvidia/cuda:10.1-cudnn7-devel

# install python
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	python3-opencv ca-certificates python3-dev python3-pip git wget sudo  \
	cmake ninja-build protobuf-compiler libprotobuf-dev && \
  rm -rf /var/lib/apt/lists/*
RUN ln -sv /usr/bin/python3 /usr/bin/python
RUN mkdir /workspace

# install detectron2
RUN pip3 --no-cache-dir install tensorboard -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 --no-cache-dir install torch==1.5 torchvision==0.6 -f https://download.pytorch.org/whl/cu101/torch_stable.html -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 --no-cache-dir install 'git+https://gitee.com/HyperDenton/fvcore' -i https://mirrors.aliyun.com/pypi/simple

RUN pip3 install scikit-build -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 install opencv-python -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 install cython -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 install "git+https://gitee.com/HyperDenton/cocoapi.git#egg=pycocotools&subdirectory=PythonAPI" -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 install 'git+https://gitee.com/HyperDenton/detectron2.git@be792b959bca9af0aacfa04799537856c7a92802' -i https://mirrors.aliyun.com/pypi/simple

# install apex
RUN cd /workspace && \
    git clone https://gitee.com/HyperDenton/apex.git && \
    cd apex && \
    python setup.py install
    
# clone and install, see https://github.com/MILVLG/bottom-up-attention.pytorch
RUN pip3 install wget -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 install streamlit -i https://mirrors.aliyun.com/pypi/simple
RUN pip3 install ray -i https://mirrors.aliyun.com/pypi/simple

RUN cd /workspace && \
    git clone https://gitee.com/HyperDenton/bottom-up-attention.pytorch && \
    cd bottom-up-attention.pytorch && \
    python setup.py build develop

WORKDIR /workspace/bottom-up-attention.pytorch
