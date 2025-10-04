#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

YAML_FILES=("secrets.yaml" "controlplane.yaml" "worker.yaml")
TALOSCONFIG_FILE="talosconfig"

for file in "${YAML_FILES[@]}"; do
  enc="${SCRIPT_DIR}/${file}.enc"
  out="${SCRIPT_DIR}/${file}"

  if [[ ! -f "$enc" ]]; then
    echo "Error: $enc not found." >&2
    exit 1
  fi

  echo "Decrypting ${file}.enc -> ${file}"
  sops -d --input-type yaml --output-type yaml "$enc" > "$out"
done

enc="${SCRIPT_DIR}/${TALOSCONFIG_FILE}.enc"
out="${SCRIPT_DIR}/${TALOSCONFIG_FILE}"

if [[ ! -f "$enc" ]]; then
  echo "Error: $enc not found." >&2
  exit 1
fi

echo "Decrypting ${TALOSCONFIG_FILE}.enc -> ${TALOSCONFIG_FILE}"
sops -d --input-type yaml --output-type yaml "$enc" > "$out"

echo "Decryption complete."

