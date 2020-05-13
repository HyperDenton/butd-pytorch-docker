FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

# install anaconda 5.2.0
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

# install pytorch 1.5 and cudatoolkit
RUN conda install pytorch=1.5 torchvision cudatoolkit=10.2 -c pytorch

# install fvcore, see https://github.com/facebookresearch/detectron2/issues/458
RUN pip install opencv-python
RUN pip install "git+https://github.com/philferriere/cocoapi.git#egg=pycocotools&subdirectory=PythonAPI"
RUN pip install 'git+https://github.com/facebookresearch/detectron2.git@v0.1'

# clone and install, see https://github.com/MILVLG/bottom-up-attention.pytorch
RUN mkdir /workspace

RUN cd /workspace && \
    git clone https://github.com/NVIDIA/apex.git && \
    cd apex && \
    python setup.py install

RUN cd /workspace && \
    git clone https://github.com/MILVLG/bottom-up-attention.pytorch && \
    cd bottom-up-attention.pytorch && \
    python setup.py build develop

WORKDIR /workspace/bottom-up-attention.pytorch