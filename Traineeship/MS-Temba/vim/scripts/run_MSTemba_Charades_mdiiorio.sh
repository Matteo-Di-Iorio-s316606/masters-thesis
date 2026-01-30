#!/usr/bin/env bash
set -euo pipefail

# --- safety: ensure Triton can call ldconfig on Grid5000 ---
export PATH="/sbin:/usr/sbin:$PATH"

# --- resolve repo root from this script location ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# --- make repo importable (rope, vim/*) ---
export PYTHONPATH="$REPO_ROOT/vim:$REPO_ROOT:$PYTHONPATH"

# --- go where MSTemba_main.py lives ---
cd "$REPO_ROOT/vim"

# --- run a SMALL smoke test (1 epoch) ---
python MSTemba_main.py \
  -dataset charades \
  -mode rgb \
  -backbone clip/i3d/ \
  -model mstemba \
  -train True \
  -rgb_root /srv/storage/stars@storage3.sophia./share/Charades/features/Charades_v1/viclip_fe2_new_pad/ \
  -num_clips 256 \
  -skip 0 \
  -comp_info False \
  -epochs 1 \
  -unisize True \
  -alpha_l 1 \
  -beta_l 0.05 \
  -batch_size 2 \
  -output_dir /srv/storage/stars@storage3.sophia.grid5000.fr/mdiiorio/outputs/mstemba_charades_test/
