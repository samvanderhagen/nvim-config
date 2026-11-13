-- Plugins LazyVim doesn't ship.
return {
  -- netrw-style directory editing: <leader>pv (like your old :Ex) or `-`
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = false, -- snacks explorer still handles `nvim .`
      view_options = { show_hidden = true },
      keymaps = { ["q"] = "actions.close" },
    },
    keys = {
      { "<leader>pv", "<cmd>Oil<cr>", desc = "Oil (current dir)" },
      { "-", "<cmd>Oil<cr>", desc = "Oil (current dir)" },
    },
  },

  -- inline color swatches for #rrggbb etc.
  { "brenoprata10/nvim-highlight-colors", event = "LazyFile", opts = {} },

  { "folke/which-key.nvim", opts = { spec = { { "<leader>p", group = "pick (old telescope keys)" } } } },
}
