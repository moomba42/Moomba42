set PATH $PATH $HOME/.bun/bin 
set PATH $PATH $HOME/.pub-cache/bin 
set PATH $PATH /opt/homebrew/bin /opt/homebrew/opt/llvm/bin
set PATH $PATH $HOME/Development/jextract-22/bin 

set DOCKER_HOST unix:///$HOME/.colima/default/docker.sock
set TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE /var/run/docker.sock

if type -q nvm
    nvm use default --silent
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
