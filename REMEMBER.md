# Things to remember
A list of commands / things that i use rarely but when i do i need to remember how. You might also call it a "cheatsheet".
A good online list of cheatsheets can be found here: https://cheatography.com/

## Docker / k8s
- `minikube start` - start the BM and k8s cluster
- `minikube stop` - stop the VM and k8s cluster
- `minikube delete` - Delete the cluster with all the data. All volumes will be lost.
- `minikube ip` - IP address of the VM where the cluster and docker engine run.
- `minikube pause` - pause k8s related containers so that they dont consume system resources
- `docker.local` host should be used to reach mapped container ports instead of `localhost` since we are running minikube, not docker desktop.
- `docker container list -f "status=running"` - list only running containers
- `docker container port NAME_OR_HASH` - show the opened ports of the given container
- `kubectl` cheatsheet - https://kubernetes.io/docs/reference/kubectl/quick-reference/

## GIT
- `git log --graph --oneline --all` - show git tree
- `git show -s --format='%ae' HASH` - show commit author
- `git rebase -i HEAD~3` - rebase onto the 3rd last commit interactively (allowing you to f.ex. squash the commits)

## Other
- `cat ~/.ssh/id_rsa.pub | pbcopy` - copy public rsa to clipboard