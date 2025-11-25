set PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH /opt/homebrew/opt/llvm/bin
set PATH $PATH $HOME/.bun/bin 
set PATH $PATH $HOME/.pub-cache/bin 
set PATH $PATH $HOME/Development/jextract-22/bin 

# Docker + Testcontainers
set DOCKER_HOST unix:///$HOME/.colima/default/docker.sock
set TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE /var/run/docker.sock

# Vulkan
set VULKAN_SDK $HOME/VulkanSDK/1.4.328.1/macOS
set PATH $PATH $VULKAN_SDK/bin
set DYLD_LIBRARY_PATH $VULKAN_SDK/lib:$DYLD_LIBRARY_PATH
set VK_ADD_LAYER_PATH $VULKAN_SDK/share/vulkan/explicit_layer.d
set VK_ICD_FILENAMES $VULKAN_SDK/share/vulkan/icd.d/MoltenVK_icd.json
set VK_DRIVER_FILES $VULKAN_SDK/share/vulkan/icd.d/MoltenVK_icd.json
set PKG_CONFIG_PATH $VULKAN_SDK/lib/pkgconfig:$PKG_CONFIG_PATH

if type -q nvm
    nvm use default --silent
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
