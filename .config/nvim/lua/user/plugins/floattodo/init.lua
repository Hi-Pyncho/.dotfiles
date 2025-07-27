local gitUtils = require('user.luaUtils.git')
local fs = require('user.luaUtils.fs')
local window = require('user.nvimHelpers.window')

local M = {}

local floatingWindow = window.createFloatingWindow({})

local defaultOpts = {
  filename = "TODO",
  border = "single",
  width = 0.8,
  height = 0.8,
}

local function getTodoPath(filename)
  local dirPath = os.getenv('HOME')
  local gitPath = gitUtils.getRootPath()

  if (gitPath) then
    dirPath = gitPath
  end

  local todoPath = dirPath .. '/' .. filename

  if vim.fn.filereadable(todoPath) == 0 then
    fs.createFile({ filePath = todoPath })
  end

  return todoPath
end

local function openFloatingFile(opts)
  local todoPath = getTodoPath(opts.filename)
  local buf = vim.fn.bufnr(todoPath, true)

  floatingWindow.open(buf)
end

local function openFloatingFile2(opts)
  if win ~= nil and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
    return
  end

  local todoPath = getTodoPath(opts.filename)

  local buf = vim.fn.bufnr(todoPath, true)

  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, todoPath)
  end

  vim.bo[buf].swapfile = false

  win = vim.api.nvim_open_win(buf, true, winConfig(opts))

  vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
    noremap = true,
    silent = true,
    callback = function()
      if vim.api.nvim_get_option_value("modified", { buf = buf }) then
        vim.notify("save your changes please", vim.log.levels.WARN)
      else
        closeWin()
      end
    end,
  })
end

local function setupUserCommands(opts)
  opts = vim.tbl_deep_extend("force", defaultOpts, opts)

  vim.api.nvim_create_user_command("TodoToggle", function()
    if (floatingWindow.isOpened()) then
      floatingWindow.close()
      return
    end

    openFloatingFile(opts)
  end, {})
end

M.setup = function(opts)
  setupUserCommands(opts)
end

return M
