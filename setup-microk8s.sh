#!/usr/bin/env bash

set -e  # exit immediately on error
set -u  # fail on undeclared variables

# Grab the directory of the scripts, in case the script is invoked from a different path
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Useful routines in common.sh
. "${SCRIPTS_DIR}/common.sh"
CHANNEL=${CHANNEL:-1.14/stable}

ensure_root

# install kubernetes .. using current known working version
snap install microk8s --classic --channel=${CHANNEL}
# use the kubectl that matches the microk8s kubernetes version
snap alias microk8s.kubectl kubectl
# export the kubectl config file in case other tools rely on this
mkdir -p $HOME/.kube
microk8s.kubectl config view --raw > $HOME/.kube/config
echo "Waiting for kubernetes core services to be ready.."
microk8s.status --wait-ready
# enable common services
microk8s.enable dns dashboard storage
# This gets around an open issue with all-in-one installs
iptables -P FORWARD ACCEPT

until [[ `kubectl get pods -n=kube-system | grep -o 'ContainerCreating' | wc -l` == 0 ]] ; do
  echo "Waiting for kubernetes addon service pods to be ready..  ("`kubectl get pods -n=kube-system | grep -o 'ContainerCreating' | wc -l`" not running)"
  sleep 5
done
