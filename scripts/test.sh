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
  local script
  script="$(mktemp)"

  cat > "${script}" <<LUA
vim.opt.runtimepath:prepend('${ROOT_DIR}')
require('kintsugi').setup({ style = '${style}', transparent = false, terminal_colors = true })
vim.cmd.colorscheme('${scheme}')

assert(vim.g.colors_name == '${scheme}', 'colors_name mismatch: ' .. tostring(vim.g.colors_name))
assert(vim.fn.hlexists('Normal') == 1, 'missing Normal highlight')
assert(vim.fn.hlexists('@keyword') == 1, 'missing @keyword highlight')
assert(vim.fn.hlexists('@keyword.type') == 1, 'missing @keyword.type highlight')
assert(vim.fn.hlexists('@keyword.modifier') == 1, 'missing @keyword.modifier highlight')
assert(vim.fn.hlexists('@keyword.type.rust') == 1, 'missing @keyword.type.rust highlight')
assert(vim.fn.hlexists('@keyword.modifier.rust') == 1, 'missing @keyword.modifier.rust highlight')
assert(vim.fn.hlexists('rustStructure') == 1, 'missing rustStructure highlight')
assert(vim.fn.hlexists('rustSigil') == 1, 'missing rustSigil highlight')

local ks = vim.api.nvim_get_hl(0, { name = '@keyword.storage', link = false })
local kt = vim.api.nvim_get_hl(0, { name = '@keyword.type', link = false })
local km = vim.api.nvim_get_hl(0, { name = '@keyword.modifier', link = false })
local ktr = vim.api.nvim_get_hl(0, { name = '@keyword.type.rust', link = false })
local kmr = vim.api.nvim_get_hl(0, { name = '@keyword.modifier.rust', link = false })
local rs = vim.api.nvim_get_hl(0, { name = 'rustStructure', link = false })
local rg = vim.api.nvim_get_hl(0, { name = 'rustSigil', link = false })
local kk = vim.api.nvim_get_hl(0, { name = '@keyword', link = false })
local kf = vim.api.nvim_get_hl(0, { name = '@keyword.function', link = false })
local op = vim.api.nvim_get_hl(0, { name = '@operator', link = false })

assert(ks.fg == kt.fg, '@keyword.type should match @keyword.storage')
assert(ks.fg == km.fg, '@keyword.modifier should match @keyword.storage')
assert(ks.fg == ktr.fg, '@keyword.type.rust should match @keyword.storage')
assert(ks.fg == kmr.fg, '@keyword.modifier.rust should match @keyword.storage')
assert(ks.fg == rs.fg, 'rustStructure should match @keyword.storage')
assert(kf.fg == kk.fg, '@keyword.function should match @keyword')
assert(rg.fg == op.fg, 'rustSigil should match @operator')

assert(vim.fn.hlexists('CmpItemAbbr') == 1, 'missing nvim-cmp highlight')
assert(vim.fn.hlexists('NeoTreeNormal') == 1, 'missing neo-tree highlight')
assert(type(vim.g.terminal_color_0) == 'string', 'terminal colors not configured')
LUA

  nvim --headless -u NONE -i NONE \
    "+lua dofile('${script}')" \
    "+qa"
  rm -f "${script}"
}

echo "Running colorscheme load checks..."
run_case "kintsugi" "dark"
run_case "kintsugi-flared" "flared"
run_case "kintsugi-light" "light"
echo "All checks passed."
