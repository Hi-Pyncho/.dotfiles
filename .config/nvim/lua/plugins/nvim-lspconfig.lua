return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {}},
    { 'saghen/blink.cmp' },
    { 'mason-org/mason-lspconfig.nvim'},
  },
  config = function()
    local lspconfig = require 'lspconfig'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', '<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>', '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local filetype = vim.api.nvim_get_option_value('filetype', { buf = event.buf} )
        local line_count = vim.api.nvim_buf_line_count(event.buf)
        local filename = vim.api.nvim_buf_get_name(event.buf)
        if filetype == 'typescript' and string.match(filename, "%.d%.ts$") and line_count > 1000 then
          client.stop()  -- Отключаем LSP для этого буфера
          return
        end
      end,
    })

    local vue_language_server_path = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
    local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = vue_language_server_path,
      languages = { 'vue' },
      configNamespace = 'typescript',
    }
    local vtsls_config = {
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              vue_plugin,
            },
          },
        },
      },
      filetypes = { 'vue' },
    }

    local vue_ls_config = {}
    vim.lsp.config('vtsls', vtsls_config)
    vim.lsp.config('vue_ls', vue_ls_config)
    vim.lsp.enable({'vtsls', 'vue_ls'})

    local servers = {
      ts_ls = {
        filetypes = {'javascript', 'typescript' },
        init_options = {
          preferences = {
            quotePreference = 'single',
          },
        },
        handlers = {
          ['_typescript.rename'] = function(_, result)
            return result
          end,
          ['textDocument/definition'] = function(err, result, ...)
            result = vim.islist(result) and result[1] or result
            vim.lsp.handlers['textDocument/definition'](err, result, ...)
          end,
        },
      },
        emmet_language_server = {
          filetypes = {'html', 'css', 'scss', 'vue' },
          init_options = {
            includeLanguages = {
              ["vue"] = "html"
            }
          }
        },
        cssls = {},
        lua_ls = {},
        clangd = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
    end,
  }
