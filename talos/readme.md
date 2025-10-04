# Talos Configurations

## Talos Patch Templates
This directory contains template files for Talos machine configuration patches. The goal
is to keep the template structure and workflow public while sourcing sensitive values
(hostnames, IPs, gateways, etc.) from environment variables that stay out of version
control.

### 1. Set Environment variables:
Set all the environement variables needed for control-plane and worker node mentioned in `.env.example` for your environment.
```.env
GATEWAY=

TALOS_CP1_IP=
TALOS_WN1_IP=
TALOS_WN2_IP=
```

### 2. Generate Patch Files:

```bash
envsubst < cp.patch.tmpl > cp.patch
envsubst < wn1.patch.tmpl > wn1.patch
envsubst < wn2.patch.tmpl > wn2.patch
```