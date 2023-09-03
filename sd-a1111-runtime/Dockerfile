FROM shennguyenrs/sd-models:latest AS downloaded
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04 AS runtime

ARG WEBUI_VERSION=v1.6.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive \
  SHELL=/bin/bash \
  PYTHONUNBUFFERED=1 \
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu \
  PATH="/workspace/venv/bin:$PATH" \
  TORCH_COMMAND="pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118"

WORKDIR /

# Package installation and setup
RUN apt update && \
  apt -y upgrade && \
  apt install -y --no-install-recommends \
  build-essential software-properties-common \
  python3.10-venv python3-pip python3-dev \
  git openssh-server libglib2.0-0 libsm6 libgl1 libxrender1 libxext6 ffmpeg wget curl psmisc rsync vim nginx \
  pkg-config libffi-dev libcairo2 libcairo2-dev libgoogle-perftools4 libtcmalloc-minimal4 apt-transport-https \
  ca-certificates && \
  update-ca-certificates && \
  apt clean && \
  rm -rf /var/lib/apt/lists/* && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

# Install runpodctl
RUN wget https://github.com/runpod/runpodctl/releases/download/v1.10.0/runpodctl-linux-amd -O runpodctl && \
  chmod a+x runpodctl && \
  mv runpodctl /usr/local/bin

# Set Python
RUN ln -s /usr/bin/python3.10 /usr/bin/python && \
  rm /usr/bin/python3 && \
  ln -s /usr/bin/python3.10 /usr/bin/python3

# Install Torch and xformers
RUN pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
  pip3 install --no-cache-dir xformers==0.0.21

# Package for Adetailer
RUN pip3 install -U --no-cache-dir ultralytics mediapipe rich protobuf

# Install Jupyter
RUN pip3 install -U --no-cache-dir jupyterlab \
  jupyterlab_widgets \
  ipykernel \
  ipywidgets \
  gdown

# Clone Web UI
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
  cd stable-diffusion-webui && \
  git checkout tags/${WEBUI_VERSION}

# Copy and cache model
COPY --from=downloaded /sd-models ./sd-models

WORKDIR /stable-diffusion-webui

COPY install-automatic.py ./
RUN python -m venv --system-site-packages /venv && \
  source /venv/bin/activate && \
  python -m install-automatic --skip-torch-cuda-test && \
  deactivate

COPY relauncher.py webui-user.sh ./

WORKDIR /

# Copy NGINX & README
COPY --from=proxy nginx.conf /etc/nginx/nginx.conf
COPY --from=proxy readme.html /usr/share/nginx/html/readme.html
COPY README.md /usr/share/nginx/html/README.md

# Copy extensions
COPY --from=downloaded /sd-vae ./sd-vae
COPY --from=downloaded /sd-upscaler ./sd-upscaler
COPY --from=downloaded /cn-models ./cn-models
COPY --from=downloaded /sd-embeddings ./sd-embeddings
COPY --from=downloaded /sd-lora ./sd-lora
COPY --from=downloaded /sd-extensions ./sd-extensions

# Start scripts
COPY --from=scripts start.sh ./
COPY pre_start.sh create-links.sh ./
RUN chmod +x /start.sh && chmod +x /pre_start.sh && chmod +x /create-links.sh

SHELL ["/bin/bash", "--login", "-c"]
CMD ["/start.sh"]
