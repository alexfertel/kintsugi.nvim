local M = {}

M.options = {
  style = "dark",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = {},
    keywords = { bold = true },
    functions = {},
    variables = {},
  },
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
  M.options.style = tostring(M.options.style or "dark"):lower()
end

return M
