if type -q nvm
    nvm use default --silent
end

if type -q minikube
    eval $(minikube docker-env)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
