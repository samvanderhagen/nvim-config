-- Plugins LazyVim doesn't ship.
return {
  -- netrw-style directory editing with `-` (<leader>pv toggles the sidebar tree, see config/keymaps.lua)
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = false, -- snacks explorer still handles `nvim .`
      view_options = { show_hidden = true },
      keymaps = { ["q"] = "actions.close" },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil (current dir)" },
    },
  },

  -- inline color swatches for #rrggbb etc.
  { "brenoprata10/nvim-highlight-colors", event = "LazyFile", opts = {} },

  { "folke/which-key.nvim", opts = { spec = { { "<leader>p", group = "pick (old telescope keys)" } } } },
}
