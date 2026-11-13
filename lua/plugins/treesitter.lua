-- LazyVim owns nvim-treesitter (main branch); just add parsers it doesn't install by default.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css", "dockerfile", "gitcommit", "git_rebase", "make", "rust", "sql", "toml", "zig",
      },
    },
  },
  { "nvim-treesitter/nvim-treesitter-context", event = "LazyFile", opts = { max_lines = 3 } },
}
