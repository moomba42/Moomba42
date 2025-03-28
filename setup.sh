#!/bin/bash

function continueConsent () {
    read -p "🔹 Do you want to continue? y/n: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi
}

function confirmTool () {
    read -p "🔹 Do you want to install [$1] $2? y/n: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        return 0;
    fi
    return 1
}

echo "🧑👉 This script will attempt to install all needed dependencies for an ✨Aleksander Długosz✨-compliant environment."
echo "Each step will require a confirmation."
echo "By default, the folliwng will be installed:"
echo "  - xcode command line tools"
echo "  - homebrew"
echo "  - fish shell"
echo
continueConsent

if ! command -v git &> /dev/null
then
    echo "🔸 git command could not be found"
    echo "✨ Installing command line tools..."
    xcode-select --install
fi

if ! command -v brew &> /dev/null
then
    echo "🔸 brew command could not be found"
    echo "✨ Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # M1
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile  
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Intel
    # (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.zprofile  
    # eval "$(/usr/local/bin/brew shellenv)"
    echo " "
fi

if ! command -v watch &> /dev/null
then
    echo "🔸 watch command could not be found"
    echo "✨ Installing watch..."
    brew install watch
fi

if ! command -v fish &> /dev/null
then
    echo "🔸 fish command could not be found"
    echo "✨ Installing fish..."
    brew install fish
    # M1
    echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
    # Intel
    # echo /usr/local/bin/fish | sudo tee -a /etc/shells
    ditto ./fish ~/.config/fish/
    (echo "SETUVAR fish_user_paths:/opt/homebrew/bin") >> ~/.config/fish/fish_variables # For M1
fi
if confirmTool "fish shell as the default shell"
then
    # M1
    chsh -s /opt/homebrew/bin/fish
    # Intel
    # chsh -s /usr/local/bin/fish
fi

if confirmTool "Amazon Corretto OpenJDK"
then
    brew tap homebrew/cask-versions
    brew install --cask corretto17
fi

if confirmTool "visual studio code"
then
    brew install --cask visual-studio-code
    echo "Use the \"code [file/dir]\" command to run visual studio code on the given file / directory."
fi


if confirmTool "jetbrains toolbox"
then
    brew install --cask jetbrains-toolbox
fi


if confirmTool "node version manager, node & fish bass"
then
    git clone https://github.com/edc/bass.git
    cd bass
    make install
    cd ../
    rm -rf bass
    brew install nvm
    mkdir ~/.nvm
    touch ~/.zshrc
    touch ~/.zshenv

    # M1
    echo "export NVM_DIR=\"\$HOME/.nvm\"" >> ~/.zshrc
    echo "[ -s \"/opt/homebrew/opt/nvm/nvm.sh\" ] && \. \"/opt/homebrew/opt/nvm/nvm.sh\"  # This loads nvm" >> ~/.zshrc
    echo "[ -s \"/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm\" ] && \. \"/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm\"  # This loads nvm bash_completion" >> ~/.zshrc

    # Intel
    # echo "export NVM_DIR=\"\$HOME/.nvm\"" >> ~/.zshrc
    # echo "[ -s \"/usr/local/opt/nvm/nvm.sh\" ] && \. \"/usr/local/opt/nvm/nvm.sh\"  # This loads nvm" >> ~/.zshrc
    # echo "[ -s \"/usr/local/opt/nvm/etc/bash_completion.d/nvm\" ] && \. \"/usr/local/opt/nvm/etc/bash_completion.d/nvm\"  # This loads nvm bash_completion" >> ~/.zshrc

    source ~/.zshenv
    source ~/.zshrc
    nvm install --lts
    echo "Use the command \"nvm\" to run the node version manager and list all possible arguments."
fi


if confirmTool "maven"
then
    brew install maven
fi


if confirmTool "ssh key" "in the ~/.ssh/ directory"
then
    ssh-keygen -t rsa
    echo "Use the following command to copy your ssh key: \"pbcopy < ~/.ssh/id_rsa.pub\""
fi


if confirmTool "docker + k8s"
then
    brew install docker
    brew install docker-compose
    brew install stern

    # M1
    brew install colima
    colima start -m 4 # start colima with 4 gigabytes of ram
    # `colima template` -> edit the startup template and change the amount of memory to 4 gigabytes, then :wq to save , and now you can just write `colima start`
    # Intel
    # brew install hyperkit 

    brew install minikube
    minikube config set driver docker
    minikube start

    eval $(minikube docker-env)
    echo "$(minikube ip) docker.local" | sudo tee -a /etc/hosts > /dev/null
    
    # M1
    # Compose is now a Docker plugin. For Docker to find this plugin, symlink it:
    mkdir -p ~/.docker/cli-plugins
    ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
    # Intel
    # mkdir -p ~/.docker/cli-plugins
    # ln -sfn /usr/local/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose

    docker run hello-world


    brew install docker-credential-helper
    brew install jq
    touch ~/.docker/config.json
    jq '. += {credsStore: "osxkeychain"}' ~/.docker/config.json > ~/.docker/config.json.tmp && mv ~/.docker/config.json.tmp ~/.docker/config.json
fi

if confirmTool "flutter" "to develop cross-platform apps"
then
    brew install --cask flutter
fi


if confirmTool "spotify" "to play some music while you code"
then
    brew install --cask spotify
fi


if confirmTool "linearmouse" "to disable built-in macos mouse acceleration"
then
    brew install --cask linearmouse
    ditto ./linearmouse ~/.config/linearmouse/
fi


if confirmTool "1password" "to manage your passwords in the command line"
then
    brew install 1password-cli
fi


if confirmTool "obsidian" "to manage your notes in markdown format"
then
    brew install --cask obsidian
fi

if confirmTool "discord" "to talk with others"
then
    brew install --cask discord
fi


if confirmTool "slack" "to talk with others"
then
    brew install --cask slack
fi


if confirmTool "figma" "to design graphics and UI"
then
    brew install --cask figma
fi


if confirmTool "jetbrains-toolbox" "to manage jetbrains products"
then
    brew install --cask jetbrains-toolbox
fi


if confirmTool "the silver searcher" "to quickly search files"
then
    brew install the_silver_searcher
    echo "Use the following command to search your files: \"ag [text] [path]\""
fi

if confirmTool "AWS cli" "to interface with AWS services"
then
    brew install awscli
fi

if confirmTool "Ngrok" "to expose local services to the internet"
then
    brew install ngrok/ngrok/ngrok
fi

## Better display: https://github.com/waydabber/BetterDisplay

echo "Please restart your shell session now."
