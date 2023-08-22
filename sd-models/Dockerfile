FROM alpine:latest

WORKDIR /

RUN apk add --no-cache wget curl git

# Cache models and extension
RUN mkdir -p /sd-models /cn-models /sd-extensions /sd-embeddings /sd-vae /sd-lora /sd-upscaler

# Download Models
RUN wget https://huggingface.co/Lykon/DreamShaper/resolve/main/DreamShaper_8_pruned.safetensors -O /sd-models/DreamShaper_8_pruned.safetensors

# Download Vae
RUN wget https://huggingface.co/hakurei/waifu-diffusion-v1-4/resolve/main/vae/kl-f8-anime2.ckpt -O /sd-vae/kl-f8-anime2.ckpt && \
    wget https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors -O /sd-vae/vae-ft-mse-840000-ema-pruned.safetensors

# Download upscaler
RUN wget https://civitai.com/api/download/models/125843 -O /sd-upscaler/4x-UltraSharp.pth

# Download Controlnet models V1.1
RUN wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11e_sd15_ip2p.pth -O /cn-models/control_v11e_sd15_ip2p.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11e_sd15_shuffle.pth -O /cn-models/control_v11e_sd15_shuffle.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth -O /cn-models/control_v11f1e_sd15_tile.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1p_sd15_depth.pth -O /cn-models/control_v11f1p_sd15_depth.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.pth -O /cn-models/control_v11p_sd15_canny.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_inpaint.pth -O /cn-models/control_v11p_sd15_inpaint.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_lineart.pth -O /cn-models/control_v11p_sd15_lineart.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_mlsd.pth -O /cn-models/control_v11p_sd15_mlsd.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_normalbae.pth -O /cn-models/control_v11p_sd15_normalbae.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth -O /cn-models/control_v11p_sd15_openpose.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_scribble.pth -O /cn-models/control_v11p_sd15_scribble.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_seg.pth -O /cn-models/control_v11p_sd15_seg.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_softedge.pth -O /cn-models/control_v11p_sd15_softedge.pth && \
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15s2_lineart_anime.pth -O /cn-models/control_v11p_sd15s2_lineart_anime.pth

# Download Embeddings
RUN wget https://huggingface.co/Lykon/DreamShaper/resolve/main/BadDream.pt -O /sd-embeddings/BadDream.pt && \
    wget https://huggingface.co/Lykon/DreamShaper/resolve/main/UnrealisticDream.pt -O /sd-embeddings/UnrealisticDream.pt && \
    wget https://huggingface.co/AsciiP/badhandv4/resolve/main/badhandv4.pt -O /sd-embeddings/badhandv4.pt && \
    wget https://civitai.com/api/download/models/9536 -O /sd-embeddings/EasyNegative.pt && \
    wget https://civitai.com/api/download/models/25820 -O /sd-embeddings/veryBadImageNegative_v1.3.pt

# Download Lora
RUN wget https://civitai.com/api/download/models/62833 -O /sd-lora/add_detail.safetensors && \
    wget https://civitai.com/api/download/models/87153 -O /sd-lora/more_details.safetensors && \
    wget https://civitai.com/api/download/models/126824 -O /sd-lora/weight_slider_v2.safetensors && \
    wget https://civitai.com/api/download/models/63006 -O /sd-lora/LowRA.safetensors

# Download Extensions
RUN git clone https://github.com/Mikubill/sd-webui-controlnet.git /sd-extensions/sd-webui-controlnet && \
    git clone https://github.com/Bing-su/adetailer.git /sd-extensions/adetailer && \
    git clone https://github.com/DominikDoom/a1111-sd-webui-tagcomplete.git /sd-extensions/a1111-sd-webui-tagcomplete && \
    git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git /sd-extensions/ultimate-upscale-for-automatic1111 && \
    git clone https://github.com/hako-mikan/sd-webui-regional-prompter.git /sd-extensions/sd-webui-regional-prompter && \
    git clone https://github.com/AlUlkesh/stable-diffusion-webui-images-browser.git /sd-extensions/stable-diffusion-webui-images-browser && \
    git clone https://github.com/KohakuBlueleaf/a1111-sd-webui-lycoris.git /sd-extensions/a1111-sd-webui-lycoris