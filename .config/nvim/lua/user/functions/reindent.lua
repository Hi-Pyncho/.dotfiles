local function reindent(opts)
  -- Проверяем, есть ли визуальное выделение
  local has_selection = opts and opts.range and opts.range ~= 0

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local view = vim.fn.winsaveview()

  if has_selection then
    -- Получаем границы выделения
    local start_line = opts.line1
    local end_line = opts.line2

    -- Сохраняем режим (чтобы вернуть его после операции)
    local mode = vim.api.nvim_get_mode().mode

    -- Переходим в нормальный режим на случай, если мы в визуальном
    vim.cmd('normal! '..mode:sub(1,1)..'\27')

    -- Применяем автоотступ для выделенного диапазона
    vim.cmd(string.format('normal! %dG=%dG', start_line, end_line))

    -- Восстанавливаем режим, если нужно
    if mode:sub(1,1) == 'v' or mode:sub(1,1) == 'V' then
      vim.cmd('normal! gv')
    end
  else
    -- Reindent всего файла
    vim.cmd('normal! gg=G')
  end

  -- Восстанавливаем позицию курсора и вид
  vim.api.nvim_win_set_cursor(0, cursor_pos)
  vim.fn.winrestview(view)

  -- Уведомление о завершении
  local msg = has_selection and "Selection reindented" or "File reindented"
  vim.notify(msg, vim.log.levels.INFO)
end

return reindent
