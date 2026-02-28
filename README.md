# kintsugi.nvim

A Neovim port of the Kintsugi VS Code theme.

## Variants

- `kintsugi` (default dark)
- `kintsugi-flared`
- `kintsugi-light`

## Built-in Integrations

This colorscheme includes tuned highlight groups for:

- `nvim-cmp`
- `which-key.nvim`
- `telescope.nvim`
- `neo-tree.nvim`
- `gitsigns.nvim`
- `todo-comments.nvim`
- `fidget.nvim`
- `crates.nvim`
- `leap.nvim`

## Installation (lazy.nvim)

```lua
{
  "alexfertel/kintsugi.nvim",
  priority = 1000,
  config = function()
    require("kintsugi").setup({
      style = "dark", -- "dark" | "flared" | "light"
      transparent = false,
    })
    vim.cmd.colorscheme("kintsugi")
  end,
}
```

## Configuration

```lua
require("kintsugi").setup({
  style = "dark", -- "dark" | "flared" | "light"
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = {},
    keywords = { bold = true },
    functions = {},
    variables = {},
  },
})
```

## Load a specific variant

```vim
:colorscheme kintsugi
:colorscheme kintsugi-flared
:colorscheme kintsugi-light
```
