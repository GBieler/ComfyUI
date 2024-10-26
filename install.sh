## install system dependencies
apt update
apt-get install psmisc
cd /workspace

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
# source ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
nvm install 20

# ViewComfy
git clone https://github.com/ViewComfy/ViewComfy 
cd /workspace/ViewComfy 
npm install
mv /workspace/ComfyUI/view_comfy.json /workspace/ViewComfy/view_comfy.json

## Installing custom nodes
# IPAdapter plus
cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
git reset --hard b188a6c

# controlnet_aux
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
cd /workspace/ComfyUI/custom_nodes/comfyui_controlnet_aux
pip install -r requirements.txt

## downloading models
cd /workspace/ComfyUI/models/controlnet
wget https://huggingface.co/lllyasviel/sd_control_collection/resolve/7cf256327b341fedc82e00b0d7fb5481ad693210/t2i-adapter_diffusers_xl_lineart.safetensors
wget https://huggingface.co/lllyasviel/sd_control_collection/resolve/7cf256327b341fedc82e00b0d7fb5481ad693210/sai_xl_depth_256lora.safetensors


cd /workspace/ComfyUI/models/clip_vision
wget https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors
mv model.safetensors CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors

mkdir /workspace/ComfyUI/models/ipadapter
cd /workspace/ComfyUI/models/ipadapter
wget https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors

cd /workspace/ComfyUI/models/checkpoints
wget https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors


## restarting ComfyUI
cd /workspace/ComfyUI
fuser -k 3000/tcp
nohup python main.py --listen --port 3000 > /dev/null 2>&1 &

## start ViewComfy
cd /workspace/ViewComfy
COMFYUI_PORT=3000 NEXT_PUBLIC_VIEW_MODE="true" npm run dev -- --port 8000



