# kintsugi.nvim

A Neovim port of the Kintsugi VS Code theme.

## Requirements

- Neovim `>= 0.9` (tested in CI on `stable` and `nightly`)

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

## Local Testing

Run a quick headless validation for all variants:

```sh
make test
```

This checks:

- each colorscheme loads (`kintsugi`, `kintsugi-flared`, `kintsugi-light`)
- core highlight groups are defined
- key integration groups are present (for example `nvim-cmp` and `neo-tree`)
- terminal palette variables are set

## CI

GitHub Actions runs the same test command on every push and pull request:

- workflow: `.github/workflows/ci.yml`
- Neovim versions: `stable`, `nightly`
- command: `make test`

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

## Installation (packer.nvim)

```lua
use({
  "alexfertel/kintsugi.nvim",
  config = function()
    require("kintsugi").setup({ style = "dark" })
    vim.cmd.colorscheme("kintsugi")
  end,
})
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

## Acknowledgements

- Kintsugi VS Code theme by Ahmed Hatem
- Owokai by toiletbril

## License

MIT. See [LICENSE](./LICENSE).
