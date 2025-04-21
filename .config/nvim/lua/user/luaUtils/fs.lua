local M = {}

---@param absoluteFilePath string
---@return boolean
function M.fileExists(absoluteFilePath)
  assert(absoluteFilePath ~= nil, 'filePath param is nil')

  local file = io.open(absoluteFilePath, 'rb')
  P(file)

  if file then file:close() end

  return file ~= nil
end

---@param params { filePath?: string, content?: string, openAfterCreate?: boolean }
function M.createFile(params)
  params = params or {}

  if not params.filePath then
    params.filePath = vim.fn.input('Enter filepath: ', vim.fn.getcwd())
  end

  params.content = params.content or ''

  local file = io.open(params.filePath, "w")

  if file then
    file:write(params.content)
    file:close()
    print("File created: " .. params.filePath)
  else
    print("Error creating file: " .. params.filePath)
  end

  if params.openAfterCreate then
    vim.cmd("edit "..params.filePath)
  end
end

---@param params { filePath?: string }
function M.readFile(params)
  params = params or {}

  if not params.filePath then
    params.filePath = vim.fn.input('Enter filepath: ', vim.fn.getcwd())
  end

  if not M.fileExists(params.filePath) then
    vim.notify('No filepath specified!', vim.log.levels.WARN)
    return {}
  end

  local file = io.open(params.filePath, "r")

  if not file then
    vim.notify("Error reading file: " .. params.filePath, vim.log.levels.WARN)
    return {}
  end

  local lines = {}

  for line in io.lines(params.filePath) do
    lines[#lines + 1] = line
  end

  return lines
end

---@param params { folderPath?: string }
function M.createFolder(params)
  params = params or {}

  if not params.folderPath then
    params.folderPath = vim.fn.input('Enter folder path: ', vim.fn.getcwd())
  end

  return os.execute('mkdir '..params.folderPath)
end

return M
