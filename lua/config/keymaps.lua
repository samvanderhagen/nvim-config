-- Loaded on VeryLazy, after LazyVim's default keymaps.
-- Press <space> and wait to see every mapping in which-key.
local map = vim.keymap.set

-- toggle the left sidebar file tree (same as LazyVim's <leader>e)
map("n", "<leader>pv", function() Snacks.explorer({ cwd = LazyVim.root() }) end, { desc = "Toggle file tree" })

-- move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- keep cursor centered
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- clipboard / registers
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

map("i", "<C-c>", "<Esc>")
map("n", "Q", "<nop>")

-- quickfix / location list
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next loclist" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev loclist" })

-- moved: <leader>s / <leader>x are LazyVim groups (search / diagnostics)
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { desc = "chmod +x file", silent = true })

-- old telescope keys -> LazyVim's picker
map("n", "<leader>pf", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", "<C-p>", function() Snacks.picker.git_files() end, { desc = "Git files" })
map("n", "<leader>ps", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>pws", function() Snacks.picker.grep_word() end, { desc = "Grep word" })
map("n", "<leader>pWs", function()
  Snacks.picker.grep_word({ search = vim.fn.expand("<cWORD>") })
end, { desc = "Grep WORD" })
map("n", "<leader>vh", function() Snacks.picker.help() end, { desc = "Help tags" })
map("n", "<leader>pb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>pr", function() Snacks.picker.recent() end, { desc = "Recent files" })
map("n", "<leader>pe", function() Snacks.explorer() end, { desc = "File tree" })

-- old zen-mode key (LazyVim's own is <leader>uz)
map("n", "<leader>zz", function() Snacks.zen() end, { desc = "Zen mode" })

-- Go error snippets (Go files only; moved from <leader>e*, which is the explorer)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(ev)
    local o = function(desc) return { buffer = ev.buf, desc = desc } end
    map("n", "<leader>ie", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", o("if err return"))
    map("n", "<leader>ia", 'oassert.NoError(err, "")<Esc>F";a', o("assert.NoError"))
    map("n", "<leader>if", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj', o("if err log.Fatalf"))
    map("n", "<leader>il", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i', o("if err logger.Error"))
  end,
})
