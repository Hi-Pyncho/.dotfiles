local M = {}

function M.getGitRelativePath()
  local filePath = vim.fn.expand('%:p');
  local gitRoot = vim.fn.systemlist('git rev-parse --show-toplevel')[1]

  if (vim.v.shell_error ~= 0) then
    return filePath
  end

  -- Преобразуем пути в абсолютные (на случай, если они содержат симлинки)
  gitRoot = vim.fn.resolve(gitRoot)
  filePath = vim.fn.resolve(filePath)

  local relativPath = filePath:sub(#gitRoot + 2)  -- +2 чтобы убрать ведущий '/'
  return relativPath
end

return M
