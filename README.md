# kubernetes-tools

Simple scripts and instructions for getting the most out of your kubernetes cluster. Includes scripts for Charmed Kubernetes and Microk8s.

## Microk8s

The goal of these scripts are to facilitate the setup and interaction with microk8s. This includes validating that some of the enabled services are ready to use.

Whereas you can clone this git repo, you can also download specific versions. As an example:

```
wget https://github.com/canonical-labs/kubernetes-tools/archive/v0.1.0.tar.gz > tar -xvd k8s-tools
```

### Common Usage

The following steps will install microk8s, enabling a few common addons like dns, dashboard and storage, and setting up .kube/config. Please review the script to familiarize yourself with everything that it does.

```
git clone https://github.com/canonical-labs/kubernetes-tools
cd kubernetes-tools
./setup-microk8s.sh
```

If you'd like to expose the kubernetes dashboard, you can run the following:

```
# assuming you are in the kubernetes-tools directory
./expose-dashboard.sh
```
