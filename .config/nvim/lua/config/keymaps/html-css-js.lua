local clipboard = require('user.nvimHelpers.clipboard')
local getSelectedText = require('user.nvimHelpers.getSelectedText')

vim.keymap.set('v', '<leader>ch', function ()
  local function generateScssFromHtml(html_str)
    -- Находим все классы в HTML с помощью паттерна
    local classes = {}
    for class in html_str:gmatch('class="([^"]+)"') do
      for single_class in class:gmatch('[^%s]+') do
        table.insert(classes, single_class)
      end
    end

    -- Удаляем дубликаты
    local unique_classes = {}
    for _, class in ipairs(classes) do
      unique_classes[class] = true
    end

    -- Сортируем классы (основные первыми)
    local sorted_classes = {}
    for class in pairs(unique_classes) do
      table.insert(sorted_classes, class)
    end
    table.sort(sorted_classes)

    -- Генерируем SCSS структуру
    local scss = {}
    local processed_blocks = {}

    for i, class in ipairs(sorted_classes) do
      -- Разделяем на блок и элемент (по BEM)
      local block, element = class:match('^([^_]+)__(.+)$')
      if not block then
        block = class
      end

      -- Добавляем основной блок если еще не добавлен
      if not processed_blocks[block] then
        table.insert(scss, string.format('.%s {', block))
        processed_blocks[block] = true
      end

      -- Добавляем элемент
      if element then
        table.insert(scss, string.format('  // .%s', class))
        table.insert(scss, string.format('  &__%s {}', element))

        if i < #sorted_classes then
          table.insert(scss, '')
        end
      end
    end

    -- Закрываем все блоки
    for _ in pairs(processed_blocks) do
      table.insert(scss, '}')
      table.insert(scss, '')
    end

    return table.concat(scss, '\n')
  end

  local res = generateScssFromHtml(getSelectedText())

  clipboard.set(res)
end, { desc = 'Generate scss from html' })
