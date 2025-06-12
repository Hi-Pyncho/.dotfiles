return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function ()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>bh1", function() harpoon:list():replace_at(1) end, { desc = 'Harpoon replace 1 buffer' })
    vim.keymap.set("n", "<leader>bh2", function() harpoon:list():replace_at(2) end, { desc = 'Harpoon replace 2 buffer' })
    vim.keymap.set("n", "<leader>bh3", function() harpoon:list():replace_at(3) end, { desc = 'Harpoon replace 3 buffer' })
    vim.keymap.set("n", "<leader>bh4", function() harpoon:list():replace_at(4) end, { desc = 'Harpoon replace 4 buffer' })

    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
  end
}
