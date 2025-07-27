local M = {}

---@param opts { width?: integer, height?: integer }
function M.createFloatingWindow(opts)
  opts = opts or {}

  local buf = -1
  local win = -1

  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local winConfig = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  local function hide()
    vim.api.nvim_win_hide(win)
  end

  local function close()
    if vim.api.nvim_get_option_value("modified", { buf = buf }) then
      vim.notify("save your changes please", vim.log.levels.WARN)
    else
      vim.api.nvim_win_close(win, true)
      win = -1
      buf = -1
    end
  end

  local function isOpened()
    return vim.api.nvim_win_is_valid(win)
  end

  local function open(buffer)
    buffer = buffer or buf

    if not vim.api.nvim_buf_is_valid(buffer) then
      buf = vim.api.nvim_create_buf(false, true)
    else
      buf = buffer
    end

    vim.bo[buf].swapfile = false

    win = vim.api.nvim_open_win(buf, true, winConfig)

    vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
      noremap = true,
      silent = true,
      callback = close,
    })

    return { buf = buf, win = win }
  end

  return { open = open, close = close, isOpened = isOpened, hide = hide }
end

return M
