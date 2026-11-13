local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                completion = { callSnippet = "Replace" },
                hint = { enable = true },
            },
        },
    },
    gopls = {
        settings = {
            gopls = {
                gofumpt = true,
                staticcheck = true,
                usePlaceholders = true,
                hints = { parameterNames = true, assignVariableTypes = true, compositeLiteralFields = true },
            },
        },
    },
    rust_analyzer = {
        settings = { ["rust-analyzer"] = { check = { command = "clippy" } } },
    },
    vtsls = {},
    basedpyright = {},
    ruff = {},
    bashls = {},
    jsonls = {},
    yamlls = {},
    clangd = {},
    zls = {},
    marksman = {},
}

return {
    -- lua_ls knows about the nvim API when editing your config
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } }, "snacks.nvim" } },
    },

    { "mason-org/mason.nvim", cmd = "Mason", opts = {} },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "saghen/blink.cmp",
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
            for name, cfg in pairs(servers) do
                vim.lsp.config(name, cfg)
            end

            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = vim.list_extend(vim.tbl_keys(servers), {
                    "stylua", "prettierd", "shfmt", "goimports", "gofumpt", "shellcheck",
                }),
            })
            -- auto-enables every installed server
            require("mason-lspconfig").setup({ automatic_enable = { exclude = { "stylua" } } })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
                callback = function(ev)
                    -- built-in 0.11+ defaults: K hover, grn rename, gra code action,
                    -- grr references, gri implementation, gO symbols, <C-s> signature
                    local function map(keys, fn, desc, mode)
                        vim.keymap.set(mode or "n", keys, fn, { buffer = ev.buf, desc = desc })
                    end
                    map("<leader>rn", vim.lsp.buf.rename, "Rename")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })
                    map("<leader>vd", vim.diagnostic.open_float, "Line diagnostics")
                    map("<leader>lh", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
                    end, "Toggle inlay hints")
                    map("grr", function() Snacks.picker.lsp_references() end, "References")
                    map("gri", function() Snacks.picker.lsp_implementations() end, "Implementations")
                end,
            })
        end,
    },

    -- formatting (format on save, <leader>f manually)
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports", "gofumpt" },
                python = { "ruff_organize_imports", "ruff_format" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                markdown = { "prettierd" },
                css = { "prettierd" },
                html = { "prettierd" },
                sh = { "shfmt" },
                rust = { "rustfmt", lsp_format = "fallback" },
            },
            format_on_save = function(buf)
                if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then return end
                return { timeout_ms = 1000, lsp_format = "fallback" }
            end,
        },
        init = function()
            vim.api.nvim_create_user_command("FormatToggle", function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
            end, {})
        end,
    },

    -- completion
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            -- <C-y> accept, <C-n>/<C-p> navigate, <C-space> open, <C-e> close (same as your old cmp)
            keymap = { preset = "default" },
            appearance = { nerd_font_variant = "mono" },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                ghost_text = { enabled = true },
            },
            signature = { enabled = true },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
    },
}
