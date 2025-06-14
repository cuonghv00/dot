#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$ROOT_DIR/bootstrap/setup.sh"
bash -n "$ROOT_DIR/bootstrap/install_devtools.sh"

echo "Syntax check passed."
