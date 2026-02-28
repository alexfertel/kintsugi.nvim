local config = require("kintsugi.config")
local theme = require("kintsugi.theme")

local M = {}

function M.setup(opts)
  config.setup(opts)
end

function M.load(style, colors_name)
  theme.load(style, colors_name)
end

return M
