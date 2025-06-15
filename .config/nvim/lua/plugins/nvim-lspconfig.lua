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

        map('gd', '<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>', '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    local servers = {
      ts_ls = {
        filetypes = { 'vue', 'javascript', 'typescript' },
        init_options = {
          preferences = {
            quotePreference = 'single',
          },
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server",
              languages = { 'vue' },
            },
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
      volar = {
        filetypes = { 'vue' },
        init_options = {
          vue = {
            hybridMode = false
          }
        }
      },
      emmet_language_server = {
        filetypes = {'html', 'css', 'scss', 'vue' },
        init_options = {
          includeLanguages = {
            ["vue"] = "html"
          }
        }
      },
      cssls = {
        filetypes = { 'scss', 'css', 'vue' }
      },
      lua_ls = {},
    }

    for server, config in pairs(servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
  end,
}
