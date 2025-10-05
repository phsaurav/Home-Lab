#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

YAML_FILES=("secrets.yaml" "controlplane.yaml" "worker.yaml")
TALOSCONFIG_FILE="talosconfig"

for file in "${YAML_FILES[@]}"; do
  src="${SCRIPT_DIR}/${file}"
  dest="${src}.enc"

  if [[ ! -f "$src" ]]; then
    echo "Error: $src not found." >&2
    exit 1
  fi

  echo "Encrypting ${file} -> ${file}.enc"
  sops -e "$src" > "$dest"
done

src="${SCRIPT_DIR}/${TALOSCONFIG_FILE}"
dest="${src}.enc"

if [[ ! -f "$src" ]]; then
  echo "Error: $src not found." >&2
  exit 1
fi

echo "Encrypting ${TALOSCONFIG_FILE} -> ${TALOSCONFIG_FILE}.enc"
sops -e --input-type yaml --output-type yaml "$src" > "$dest"

echo "Encryption complete."
