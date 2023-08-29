echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync --remove-source-files -rlptDu --ignore-existing /venv/ /workspace/venv/

echo "**** syncing stable diffusion to workspace, please wait ****"
rsync --remove-source-files -rlptDu --ignore-existing /stable-diffusion-webui/ /workspace/stable-diffusion-webui/

ln -s /cn-models/* /workspace/stable-diffusion-webui/models/ControlNet/
ln -s /sd-lora/* /workspace/stable-diffusion-webui/models/Lora/
ln -s /sd-models/* /workspace/stable-diffusion-webui/models/Stable-diffusion/
ln -s /sd-vae/* /workspace/stable-diffusion-webui/models/VAE/
ln -s /sd-upscaler/* /workspace/stable-diffusion-webui/models/ESRGAN/
ln -s /sd-extensions/* /workspace/stable-diffusion-webui/extensions/
ln -s /sd-embeddings/* /workspace/stable-diffusion-webui/embeddings/

if [[ $RUNPOD_STOP_AUTO ]]
then
    echo "Skipping auto-start of webui"
else
    echo "Started webui through relauncher script"
    cd /workspace/stable-diffusion-webui
    python relauncher.py &
fi
