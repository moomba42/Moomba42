# Things to remember
A list of commands / things that i use rarely but when i do i need to remember how. You might also call it a "cheatsheet".
A good online list of cheatsheets can be found here: https://cheatography.com/

## Docker / k8s
- `colima start` - start the colima VM (Apple Silicon)
- `colima stop` - stop the VM (Apple Silicon)
- `minikube start` - start k8s cluster (and VM if using hyperkit)
- `minikube stop` - stop k8s cluster (and VM if using hyperkit)
- `minikube delete` - Delete the cluster with all the data. All volumes will be lost.
- `minikube ip` - IP address of the VM where the cluster and docker engine run.
- `minikube pause` - pause k8s related containers so that they dont consume system resources
- `docker.local` host should be used to reach mapped container ports instead of `localhost` since we are running minikube, not docker desktop.
- `docker container list -f "status=running"` - list only running containers
- `docker container port NAME_OR_HASH` - show the opened ports of the given container
- `kubectl` cheatsheet - https://kubernetes.io/docs/reference/kubectl/quick-reference/

### Direct resource manipulation
- `kubectl delete [resource] [identifier]`
- `kubectl describe [resource] [identifier]` - status of the given resource in human readable format
- `kubectl get [resource] [identifier] -o yaml` - output given resource definition in yaml format 
- `kubectl get events --watch-only` - listen for new events across the whole cluster
- `kubectl create deployment [deployment-name] --image [docker-image-identifier]` - create a new deployment

### Logs
- `stern [pod-query]` - get the logs of all containers in a given pod, in a nice format (**best option**)
- `kubectl logs [resource]/[identifier]` - get the logs of a pod that is implied by a given resource
- `kubectl logs [pod-identifier] --follow --tail 1` - get the last log line of the specified pod and then listen for new logs
- `kubectl logs [pod-identifier] -c [container-name] --follow --tail 1` - get the last log line of the specified pod container and then listen for new logs
- `kubectl logs [pod-identifier] --all-containers=true` - get the logs of all containers in the given pod, not just the first one
- `kubectl logs -l [label]` - get the logs for a given label (look for labels using kubectl describe)

### Others
- `kubectl explain [resourcetype]` - Show the documentation on how a certain resource type is built

## GIT
- `git log --graph --oneline --all` - show git tree
- `git show -s --format='%ae' HASH` - show commit author
- `git rebase -i HEAD~3` - rebase onto the 3rd last commit interactively(whatever commit was last comitted, and two before it, inclusively), allowing you to f.ex. squash the commits.

## Other
- `cat ~/.ssh/id_rsa.pub | pbcopy` - copy public rsa to clipboard
- `ag -i -g 'filename' ~/some/directory` - search all files in a given directory containing the pattern "filename" in their file name, case insensitively
- `minikube ssh grep host.minikube.internal /etc/hosts | cut -f1` - prints out the internal host ip that is used to access host resources from within minikube pods. 
- `brew install --formula --build-from-source ext4fuse.rb`- installs ext4 file system support to macFUSE using the [ext4fuse.rb](ext4fuse.rb) ruby script