-- Extra language servers and tools on top of LazyVim + its lang extras.
-- LazyVim installs these through Mason and wires up keymaps, completion and format-on-save.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              staticcheck = true,
              hints = { parameterNames = true, assignVariableTypes = true, compositeLiteralFields = true },
            },
          },
        },
        rust_analyzer = {
          settings = { ["rust-analyzer"] = { check = { command = "clippy" } } },
        },
        bashls = {},
        yamlls = {},
        zls = {},
        marksman = {},
      },
    },
  },

  { "mason-org/mason.nvim", opts = { ensure_installed = { "shellcheck" } } },

  -- completion: keep the old nvim-cmp keys (<C-y> accept, <C-n>/<C-p> move)
  {
    "saghen/blink.cmp",
    opts = { keymap = { preset = "default" } },
  },
}
