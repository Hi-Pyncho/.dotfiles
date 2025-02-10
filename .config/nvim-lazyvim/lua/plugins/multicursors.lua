return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "v" }, "<up>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "v" }, "<c-q>", function()
      mc.clearCursors()
    end)
    set({ "n", "v" }, "<M-C-j>", function()
      mc.lineAddCursor(1)
    end)
  end,
}
