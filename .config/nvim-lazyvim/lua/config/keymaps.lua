-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local delMarkOnCurLine = require("user.functions.deleteMark")

-- Diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to prev [D]iagnostic message" })

-- Marks
vim.keymap.set("n", "dm", delMarkOnCurLine, { desc = "Remove mark on the current line" })

-- Buffer
vim.keymap.set("n", "<M-[>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer", silent = true })
vim.keymap.set("n", "<M-]>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<C-w>", function()
  Snacks.bufdelete()
end, { desc = "Remove current buffer" })

vim.keymap.set(
  "n",
  "<leader>rc",
  "<cmd>%s/console.log(.*)//g<cr>",
  { desc = "Remove all log functions in the current file" }
)
vim.keymap.set("n", "<leader><leader>x", "<cmd>:w<cr><cmd>:source %<cr>", { desc = "Execute current file" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit from insert mode", silent = true, noremap = true })

-- Delete keymaps
vim.keymap.set("i", "<c-c>", function() end)

-- Flash
vim.keymap.set({ "x", "n", "o" }, "f", function()
  require("flash").jump()
end, { desc = "Flash and jump to position" })

-- Neo-tree
vim.keymap.set("n", "<leader>i", function()
  require("neo-tree.command").execute({
    toggle = true,
    -- action = "focus", -- OPTIONAL, this is the default value
    -- source = "filesystem", -- OPTIONAL, this is the default value
    -- position = "left", -- OPTIONAL, this is the default value
    -- reveal_force_cwd = true, -- change cwd without asking if needed
  })
end, { desc = "Open neo-tree at current file or working directory" })
-- vim.keymap.set("n", "<leader>E", "fe", { desc = "Open neo-tree (git)" })
