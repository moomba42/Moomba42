# Homebrew
if test -e /opt/homebrew/sbin
    set PATH /opt/homebrew/sbin $PATH
end
if test -e /opt/homebrew/bin
    set PATH /opt/homebrew/bin $PATH
end

# LLVM
if type -q brew
   and test -e /opt/homebrew/Cellar/llvm
   and test -e /opt/homebrew/opt/llvm/bin
    set PATH $PATH /opt/homebrew/opt/llvm/bin
end

# Bun
if type -q bun
    set PATH $PATH $HOME/.bun/bin 
end

# Flutter
if type -q dart
   or type -q flutter
    set PATH $PATH $HOME/.pub-cache/bin
end 

# Java Project Panama
if test -e $HOME/Development/jextract-22/bin
    set PATH $PATH $HOME/Development/jextract-22/bin 
end

# Docker + Testcontainers
if type -q colima
    set DOCKER_HOST unix:///$HOME/.colima/default/docker.sock
    set TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE /var/run/docker.sock
end

# Vulkan
if test -e $HOME/VulkanSDK/1.4.328.1/macOS
    set VULKAN_SDK $HOME/VulkanSDK/1.4.328.1/macOS
    set PATH $PATH $VULKAN_SDK/bin
    set DYLD_LIBRARY_PATH $VULKAN_SDK/lib:$DYLD_LIBRARY_PATH
    set VK_ADD_LAYER_PATH $VULKAN_SDK/share/vulkan/explicit_layer.d
    set VK_ICD_FILENAMES $VULKAN_SDK/share/vulkan/icd.d/MoltenVK_icd.json
    set VK_DRIVER_FILES $VULKAN_SDK/share/vulkan/icd.d/MoltenVK_icd.json
    set PKG_CONFIG_PATH $VULKAN_SDK/lib/pkgconfig:$PKG_CONFIG_PATH
end

# Android SDK
if test -e $HOME/Library/Android/sdk
    set ANDROID_HOME $HOME/Library/Android/sdk
    set PATH $PATH $ANDROID_HOME/tools
    set PATH $PATH $ANDROID_HOME/tools/bin
    set PATH $PATH $ANDROID_HOME/platform-tools
end

# Node version manager
if type -q nvm
    nvm use default --silent
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Taken from https://www.asciiart.eu/mythology/dragons
# RED = \e[0;31m
# GREEN = \e[0;32m
# WHITE = \e[0;37m
# GRAY = \e[0;90m
echo -e "\e[0;32m                                                          "
echo "                   ___====-_  _-====___                   "
echo "             _--^^^#####//      \\\\#####^^^--_             "
echo "          _-^##########// (    ) \\\\##########^-_          "
echo "         -############//  |\\^^/|  \\\\############-         "
echo -e "       _/############//   (\e[0;31m@\e[0;32m::\e[0;31m@\e[0;32m)   \\\\############\\_       "
echo "      /#############((     \\\\//     ))#############\\      "
echo "     -###############\\\\    (oo)    //###############-     "
echo "    -#################\\\\  / VV \\  //#################-    "
echo "   -###################\\\\/      \\//###################-   "
echo "  _#/|##########/\\######(   /\\   )######/\\##########|\\#_  "
echo "  |/ |#/\\#/\\#/\\/  \\#/\\##\\  |  |  /##/\\#/  \\/\\#/\\#/\\#| \\|  "
echo "  `  |/  V  V  `   V  \\#\\| |  | |/#/  V   '  V  V  \\|  '  "
echo "     `   `  `      `   / | |  | | \\   '      '  '   '     "
echo "                      (  | |  | |  )                      "
echo -e "\e[0;37m.--------------------\e[0;32m__\\ | |  | | /__\e[0;37m--------------------."
echo -e "|                   \e[0;32m(vvv(VVV)(VVV)vvv)\e[0;37m                   |"
echo "+--------------------------------------------------------+"
echo -e "|\e[0;90m4D6F6F6D626134322D636F6D70617469626C65207465726D696E616C\e[0;37m|"
echo "+--------------------------------------------------------+"