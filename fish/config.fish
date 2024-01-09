if type -q minikube
    eval $(minikube docker-env)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
