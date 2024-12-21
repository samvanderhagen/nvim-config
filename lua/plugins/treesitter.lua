return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter")
        treesitter.setup{
            ensure_installed = {"typescript", "javascript", "c", "lua", "go", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust"},

            auto_install = true,
            sync_install = false,
            indent = {enable=true},
            highlight = {
                enable = true,

                additional_vim_regex_highlighting = false
            }
        }
    end,
}
