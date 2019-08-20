#!/usr/bin/env bash

set -e  # exit immediately on error
set -u  # fail on undeclared variables

# Grab the directory of the scripts, in case the script is invoked from a different path
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Useful routines in common.sh
. "${SCRIPTS_DIR}/common.sh"

ensure_root

# reset microk8s to state that microk8s just installed.
microk8s.reset
mkdir -p $HOME/.kube
microk8s.kubectl config view --raw > $HOME/.kube/config
microk8s.status --wait-ready
microk8s.enable dns dashboard storage

ensure_pods_ready
