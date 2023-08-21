FROM nvidia/cuda:11.8.0-devel-ubuntu22.04 AS runtime

ARG WEBUI_VERSION=v1.5.1

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
  pip3 install --no-cache-dir xformers==0.0.20

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

# Cache models and extension
RUN mkdir -p /sd-models /cn-models /sd-extensions /sd-embeddings /sd-vae /sd-lora

# Download Models
RUN wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned.safetensors /sd-models/v1-5-pruned.safetensors -O /sd-models/v1-5-pruned.safetensors

WORKDIR /stable-diffusion-webui
COPY cache-sd-models.py install-automatic.py ./
RUN python -m venv --system-site-packages /venv && \
  source /venv/bin/activate && \
  python -m install-automatic --skip-torch-cuda-test && \
  deactivate

# Cache the SD 1.5 model
RUN source /venv/bin/activate && \
  python cache-sd-model.py --use-cpu=all --ckpt /sd-models/v1-5-pruned.safetensors && \
  deactivate

COPY relauncher.py webui-user.sh ./

WORKDIR /

# Copy NGINX & README 
COPY /proxy/nginx.conf /etc/nginx/nginx.conf
COPY /proxy/readme.html /usr/share/nginx/html/readme.html
COPY README.md /usr/share/nginx/html/README.md

# Download Vae
RUN wget https://huggingface.co/hakurei/waifu-diffusion-v1-4/blob/main/vae/kl-f8-anime2.ckpt -O /sd-vae/kl-f8-anime2.ckpt && \
  wget https://huggingface.co/stabilityai/sd-vae-ft-mse-original/blob/main/vae-ft-mse-840000-ema-pruned.safetensors

# Download Controlnet models
RUN wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11e_sd15_ip2p.pth -O /cn-models/control_v11e_sd15_ip2p.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11e_sd15_shuffle.pth -O /cn-models/control_v11e_sd15_shuffle.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11f1e_sd15_tile.pth -O /cn-models/control_v11f1e_sd15_tile.pth && \ 
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11f1p_sd15_depth.pth -O /cn-models/control_v11f1p_sd15_depth.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_canny.pth -O /cn-models/control_v11p_sd15_canny.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_inpaint.pth -O /cn-models/control_v11p_sd15_inpaint.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_lineart.pth -O /cn-models/control_v11p_sd15_lineart.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_mlsd.pth -O /cn-models/control_v11p_sd15_mlsd.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_normalbae.pth -O /cn-models/control_v11p_sd15_normalbae.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_openpose.pth -O /cn-models/control_v11p_sd15_openpose.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_scribble.pth -O /cn-models/control_v11p_sd15_scribble.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_seg.pth -O /cn-models/control_v11p_sd15_seg.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_softedge.pth -O /cn-models/control_v11p_sd15_softedge.pth && \
  wget https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15s2_lineart_anime.pth -O /cn-models/control_v11p_sd15s2_lineart_anime.pth

# Download Extensions
RUN git clone https://github.com/Mikubill/sd-webui-controlnet.git /sd-extensions/sd-webui-controlnet && \
  git clone https://github.com/Bing-su/adetailer.git /sd-extensions/adetailer && \
  git clone https://github.com/DominikDoom/a1111-sd-webui-tagcomplete.git /sd-extensions/a1111-sd-webui-tagcomplete && \
  git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git /sd-extensions/ultimate-upscale-for-automatic1111 && \
  git clone https://github.com/hako-mikan/sd-webui-regional-prompter.git /sd-extensions/sd-webui-regional-prompter && \
  git clone https://github.com/AlUlkesh/stable-diffusion-webui-images-browser/ /sd-extensions/stable-diffusion-webui-images-browser && \
  git clone https://github.com/KohakuBlueleaf/a1111-sd-webui-lycoris.git /sd-extensions/a1111-sd-webui-lycoris && \
  git clone git clone https://github.com/adieyal/sd-dynamic-prompting/ /sd-extensions/sd-dynamic-prompting

# Download Lora
RUN wget https://civitai.com/api/download/models/62833 -O /sd-lora/add_detail.safetensors && \
  wget https://civitai.com/api/download/models/87153 -O /sd-lora/more_details.safetensors && \
  wget https://civitai.com/api/download/models/126824 -O /sd-lora/weight_slider_v2.safetensors && \
  wget https://civitai.com/api/download/models/63006 -O /sd-lora/LowRA.safetensors

# Download Embeddings
RUN wget https://civitai.com/api/download/models/77169 -O /sd-embeddings/BadDream.pt && \
  wget https://civitai.com/api/download/models/77173 -O /sd-embeddings/UnrealisticDream.pt && \
  wget https://civitai.com/api/download/models/20068 -O /sd-embeddings/badhandv4.pt && \
  wget https://civitai.com/api/download/models/9536 -O /sd-embeddings/EasyNegative.pt

# Start scripts
COPY pre_start.sh start.sh ./
RUN chmod +x /start.sh && chmod +x /pre_start.sh

SHELL ["/bin/bash", "--login", "-c"]
CMD ["/start.sh"]
