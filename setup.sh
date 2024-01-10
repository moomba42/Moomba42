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
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.zprofile  
    eval "$(/usr/local/bin/brew shellenv)"
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
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
    ditto ./fish ~/.config/fish/
fi
if confirmTool "fish shell as the default shell"
then
    chsh -s /usr/local/bin/fish
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
    echo "export NVM_DIR=\"\$HOME/.nvm\"" >> ~/.zshenv
    echo "[ -s \"/usr/local/opt/nvm/nvm.sh\" ] && \. \"/usr/local/opt/nvm/nvm.sh\"  # This loads nvm" >> ~/.zshrc
    echo "[ -s \"/usr/local/opt/nvm/etc/bash_completion.d/nvm\" ] && \. \"/usr/local/opt/nvm/etc/bash_completion.d/nvm\"  # This loads nvm bash_completion" >> ~/.
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
    brew install hyperkit
    brew install minikube
    brew install stern
    minikube start
    eval $(minikube docker-env)
    echo "$(minikube ip) docker.local" | sudo tee -a /etc/hosts > /dev/null
    docker run hello-world
fi


if confirmTool "spotify" "to play some music while you code"
then
    brew install --cask spotify
fi


if confirmTool "1password" "to manage your passwords in the command line"
then
    brew install 1password-cli
fi

echo "Please restart your shell session now."
