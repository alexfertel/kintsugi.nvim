#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export NVIM_LOG_FILE="${TMPDIR:-/tmp}/kintsugi.nvim.log"

if ! command -v nvim >/dev/null 2>&1; then
  echo "error: nvim is not installed or not on PATH" >&2
  exit 1
fi

run_case() {
  local scheme="$1"
  local style="$2"

  nvim --headless -u NONE -i NONE \
    "+set rtp^=${ROOT_DIR}" \
    "+lua require('kintsugi').setup({ style = '${style}', transparent = false, terminal_colors = true })" \
    "+colorscheme ${scheme}" \
    "+lua assert(vim.g.colors_name == '${scheme}', 'colors_name mismatch: ' .. tostring(vim.g.colors_name))" \
    "+lua assert(vim.fn.hlexists('Normal') == 1, 'missing Normal highlight')" \
    "+lua assert(vim.fn.hlexists('@keyword') == 1, 'missing @keyword highlight')" \
    "+lua assert(vim.fn.hlexists('CmpItemAbbr') == 1, 'missing nvim-cmp highlight')" \
    "+lua assert(vim.fn.hlexists('NeoTreeNormal') == 1, 'missing neo-tree highlight')" \
    "+lua assert(type(vim.g.terminal_color_0) == 'string', 'terminal colors not configured')" \
    "+qa"
}

echo "Running colorscheme load checks..."
run_case "kintsugi" "dark"
run_case "kintsugi-flared" "flared"
run_case "kintsugi-light" "light"
echo "All checks passed."
