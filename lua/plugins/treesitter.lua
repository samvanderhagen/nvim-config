-- nvim-treesitter `main` branch (the only one supporting nvim 0.12)
local parsers = {
    "bash", "c", "cpp", "css", "diff", "dockerfile", "go", "gomod", "gosum", "html",
    "javascript", "json", "lua", "luadoc", "make", "markdown", "markdown_inline",
    "python", "query", "regex", "rust", "sql", "toml", "tsx", "typescript", "vim",
    "vimdoc", "yaml", "zig", "gitcommit", "git_rebase",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.install(parsers)

            local available = {}
            for _, p in ipairs(ts.get_available()) do available[p] = true end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if not lang then return end
                    local function start()
                        if not vim.api.nvim_buf_is_valid(ev.buf) then return end
                        if pcall(vim.treesitter.start, ev.buf, lang) then
                            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    end
                    if vim.list_contains(ts.get_installed(), lang) then
                        start()
                    elseif available[lang] then
                        -- auto-install parsers for new languages
                        ts.install(lang):await(vim.schedule_wrap(start))
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        opts = { max_lines = 3 },
    },
}
