-- Your original harpoon keys
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { settings = { save_on_toggle = true } },
    keys = function()
      local h = function() return require("harpoon") end
      return {
        { "<leader>a", function() h():list():add() end, desc = "Harpoon add" },
        { "<leader>A", function() h():list():prepend() end, desc = "Harpoon prepend" },
        { "<C-e>", function() h().ui:toggle_quick_menu(h():list()) end, desc = "Harpoon menu" },
        { "<C-h>", function() h():list():select(1) end, desc = "Harpoon 1" },
        { "<C-t>", function() h():list():select(2) end, desc = "Harpoon 2" },
        { "<C-n>", function() h():list():select(3) end, desc = "Harpoon 3" },
        { "<C-s>", function() h():list():select(4) end, desc = "Harpoon 4" },
        { "<leader><C-h>", function() h():list():replace_at(1) end, desc = "Harpoon set 1" },
        { "<leader><C-t>", function() h():list():replace_at(2) end, desc = "Harpoon set 2" },
        { "<leader><C-n>", function() h():list():replace_at(3) end, desc = "Harpoon set 3" },
        { "<leader><C-s>", function() h():list():replace_at(4) end, desc = "Harpoon set 4" },
      }
    end,
  },
}
