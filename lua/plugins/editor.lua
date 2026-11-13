return {
    -- show pending keybinds
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                { "<leader>p", group = "pick/find" },
                { "<leader>g", group = "git" },
                { "<leader>h", group = "hunks" },
                { "<leader>l", group = "lsp" },
                { "<leader>t", group = "trouble" },
                { "<leader>e", group = "go err" },
                { "<leader>z", group = "zen" },
                { "gs", group = "surround" },
                { "<leader>b", group = "buffer" },
            },
        },
    },

    -- netrw-like file editing; <leader>pv like before, `-` from any buffer
    {
        "stevearc/oil.nvim",
        lazy = false,
        opts = {
            default_file_explorer = false, -- snacks explorer owns directories
            view_options = { show_hidden = true },
            keymaps = { ["q"] = "actions.close" },
        },
        keys = {
            { "<leader>pv", "<cmd>Oil<cr>", desc = "Oil (parent dir)" },
            { "-", "<cmd>Oil<cr>", desc = "Oil (parent dir)" },
        },
    },

    -- harpoon 2
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            local map = vim.keymap.set
            map("n", "<leader>A", function() harpoon:list():prepend() end, { desc = "Harpoon prepend" })
            map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
            map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            map("n", "<C-h>", function() harpoon:list():select(1) end)
            map("n", "<C-t>", function() harpoon:list():select(2) end)
            map("n", "<C-n>", function() harpoon:list():select(3) end)
            map("n", "<C-s>", function() harpoon:list():select(4) end)
            map("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
            map("n", "<leader><C-t>", function() harpoon:list():replace_at(2) end)
            map("n", "<leader><C-n>", function() harpoon:list():replace_at(3) end)
            map("n", "<leader><C-s>", function() harpoon:list():replace_at(4) end)
        end,
        keys = { "<leader>a", "<leader>A", "<C-e>", "<C-h>", "<C-t>", "<C-n>", "<C-s>" },
    },

    -- jump anywhere: s{chars}, S for treesitter select
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = { modes = { search = { enabled = false } } },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
        },
    },

    -- textobjects, surround, pairs
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            require("mini.surround").setup({ -- gsa / gsd / gsr (s is flash)
                mappings = { add = "gsa", delete = "gsd", find = "gsf", find_left = "gsF",
                    highlight = "gsh", replace = "gsr", update_n_lines = "gsn" },
            })
            require("mini.pairs").setup()
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end,
    },

    -- git signs + hunk actions
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            current_line_blame = false,
            on_attach = function(buf)
                local gs = require("gitsigns")
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buf, desc = desc })
                end
                map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
                map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
                map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
                map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
                map("n", "<leader>hp", gs.preview_hunk_inline, "Preview hunk")
                map("n", "<leader>hd", gs.diffthis, "Diff this")
                map("n", "<leader>hb", gs.toggle_current_line_blame, "Toggle blame")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Hunk")
            end,
        },
    },

    -- diagnostics / quickfix list UI
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
        keys = {
            { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
            { "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
            { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
            { "<leader>ts", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols outline" },
        },
    },

    { "folke/todo-comments.nvim", event = "VeryLazy", opts = {} },

    { "mbbill/undotree", keys = { { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undotree" } } },

    -- show colors like #ff0000 inline
    { "brenoprata10/nvim-highlight-colors", event = "VeryLazy", opts = {} },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                component_separators = "",
                section_separators = { left = "\u{e0b4}", right = "\u{e0b6}" },
            },
            sections = {
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "diagnostics", "filetype" },
            },
        },
    },
}
