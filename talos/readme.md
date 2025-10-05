# Talos Configurations

## Prerequisite
### Set Environment Variables:
Set all the environement variables needed for control-plane and worker node mentioned in `.env.example` for your environment.
```.env
GATEWAY=

TALOS_CP1_IP=
TALOS_WN1_IP=
TALOS_WN2_IP=
```

## Generate Base Talos Config

```bash
mkdir _out
talosctl gen secrets --output-file _out/secrets.yaml
talosctl gen config talos-k8s https://$TALOS_CP1_IP:6443 --with-secrets _out/secrets.yaml --install-disk /dev/sda --output-dir _out
```

## SOPS to encrypt or decrypt
The files in _out are sensetive. It holds certificates with cluster and networking related secret informations. That's why these configuration files are encrypted with SOPS:

### To Encrypt-Decrypt:
```bash
sh ./_out/encrypt.sh
sh ./_out/decrypt.sh
```

 >Note: decrypt will overwrite any existing plaintext files. If you prefer
 in-place editing (and are okay with sops opening your editor), you can run sops
 secrets.yaml.enc, etc.

## Talos Patch Templates

Generate patch files:
```bash
cd patches
envsubst < cp.patch.tmpl > cp.patch
envsubst < wn1.patch.tmpl > wn1.patch
envsubst < wn2.patch.tmpl > wn2.patch
```

## Apply Configuration + Patches

### For Controlplane:
```bash
talosctl apply-config --insecure --nodes $TALOS_CP1_IP --config-patch @./patches/cp.patch --talosconfig ./_out/talosconfig --file ./_out/controlplane.yaml
```

### For Workers:
```bash
talosctl apply-config --insecure --nodes $TALOS_WN1_IP --config-patch @./patches/wn1.patch --talosconfig ./_out/talosconfig --file ./_out/worker.yaml
```

## Final Stage

```bash
talosctl config endpoint $TALOS_CP1_IP  # Set Controlplane IP as endpoint
talosctl config node $TALOS_CP1_IP
talosctl bootstrap     # Bootstrap everything (Only On Initialization)
```

## Dashboard

```bash
talosctl dashboard  # Controlplane dashboard
talosctl dashboard --nodes $TALOS_CP1_IP,$TALOS_WN1_IP,$TALOS_WN2_IP
```

## Future Expantion

After adding talos resource running [Apply Configuration + Patches](#apply-configuration--patches). This will add the new node to the cluster.