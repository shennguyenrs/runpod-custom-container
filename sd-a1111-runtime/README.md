## 🚀 RunPod Automatic1111 Runtime Image

This template includes downloaded:

- Stable Diffusion WebUI: [v1.6.0](https://github.com/AUTOMATIC1111/stable-diffusion-webui/releases/tag/v1.6.0)
- ControlNet: commit 2b12b27 on Sep 7, 2023
- Models:
  - [Dreamshaper_v8](https://civitai.com/models/4384/dreamshaper)
  - [epiCRealism](https://civitai.com/models/25694/epicrealism)
- VAE:
  - [kl-f8-anime2](https://civitai.com/models/23906?modelVersionId=28569)
  - [vae-ft-mse-840000-ema-pruned](https://civitai.com/models/76118/vae-ft-mse-840000-ema-pruned)
- Upscaler:
  - [4x-Ultrasharp](https://civitai.com/models/116225)
  - [4x_NMKD-Superscale-SP_178000_G](https://huggingface.co/uwg/upscaler/blob/main/ESRGAN/4x_NMKD-Superscale-SP_178000_G.pth)
- Controlnet v1.1:
  - [control_v11f1e_sd15_tile](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11f1e_sd15_tile.pth)
  - [control_v11f1p_sd15_depth](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11f1p_sd15_depth.pth)
  - [control_v11p_sd15_canny](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_canny.pth)
  - [control_v11p_sd15_inpaint](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_inpaint.pth)
  - [control_v11p_sd15_lineart](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_lineart.pth)
  - [control_v11p_sd15_openpose](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_openpose.pth)
  - [control_v11p_sd15_softedge](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_softedge.pth)
  - [control_v11p_sd15s2_lineart_anime](https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15s2_lineart_anime.pth)
- Embeddings:
  - [BadDream + UnrealisticDream v1.0](https://civitai.com/models/72437)
  - [badhandv4](https://civitai.com/models/16993?modelVersionId=20068)
  - [EasyNegative](https://civitai.com/models/7808?modelVersionId=9208)
  - [veryBadImageNegative_v1.3](https://civitai.com/models/11772?modelVersionId=25820)
  - [epiCNegative](https://civitai.com/models/89484?modelVersionId=95263)
  - [epiCRealism](https://civitai.com/models/89484?modelVersionId=95256)
- Lora:
  - [Detail Tweaker LoRA](https://civitai.com/models/58390?modelVersionId=62833)
  - [Add More Details - Detail Enhancer / Tweaker (细节调整) LoRA](https://civitai.com/models/82098?modelVersionId=87153)
  - [Weight Slider - LoRA](https://civitai.com/models/112552?modelVersionId=126824)
  - [epiCRealismHelper](https://civitai.com/models/110334/epicrealismhelper)
- Extensions:
  - [sd-webui-controlnet](https://github.com/Mikubill/sd-webui-controlnet.git)
  - [adetailer](https://github.com/Bing-su/adetailer.git)
  - [ultimate-upscale-for-automatic1111](https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git)
  - [stable-diffusion-webui-images-browser](https://github.com/AlUlkesh/stable-diffusion-webui-images-browser.git)
  - [a1111-sd-webui-lycoris](https://github.com/KohakuBlueleaf/a1111-sd-webui-lycoris.git)
  - [sd-webui-openpose-editor](https://github.com/huchenlei/sd-webui-openpose-editor.git)
  - [multidiffusion-upscaler-for-automatic1111](https://github.com/pkuliyi2015/multidiffusion-upscaler-for-automatic1111.git)

Maintain by [shennguyenrs](https://github.com/shennguyenrs)

### 📝 General

⚠️ **Please note, this doesn't work out-of-the-box with encrypted volumes!**

This is a RunPod packaged template for stable diffusion using the Automatic1111 repository. RunPod does not maintain the code for this repo, we merely package it for easier use.

If you need help with settings, etc., feel free to ask us, but remember we're not stable diffusion experts! 😅 We'll do our best to assist, but the RunPod community or automatic/stable diffusion communities might be more effective in helping you.

🔵 **Please wait until the GPU Utilization % is 0 before attempting to connect. You'll likely encounter a 502 error if the pod is still getting ready for use.**

### ⚙️ Changing Launch Parameters

You might be used to altering a different file for your launch parameters. In our case, we use `relauncher.py` located in the `webui` directory to manage the launch flags like `--xformers`. Feel free to edit this file, and then restart your pod via the hamburger menu for the changes to take effect. `--xformers` and `--api` are commonly inquired about.

### 📥 Using Your Own Models

The best ways to introduce your models to your pod is by using [runpodctl](https://github.com/runpod/runpodctl/blob/main/README.md) or by uploading them to Google Drive or another cloud storage provider and downloading them to your pod from there.

🔗 Re-links all pre-builts models
In case, all or some the pre-built models are not in the correct locations in the workspace, you can open terminal at root directory / and run command sh create_links.sh.

### 🚚 Uploading to Google Drive

If you're finished with the pod and want to transfer things to Google Drive, [this colab](https://colab.research.google.com/drive/1ot8pODgystx1D6_zvsALDSvjACBF1cj6) can assist you using `runpodctl`. You can run `runpodctl` in a web terminal (found in the pod connect menu), or in a terminal on the desktop.

### 🔌 Template Ports

- **3001** | HTTP - This is the WebUI port that gets proxied to the internal 3000 port.
- **8888** | HTTP - This is the JupyterLab port that gets proxied to the internal 8888 port.
- **22** | TCP - This is the SSH port that gets proxied to the internal 22 port.
