local M = {}

local function optiones(options)
  -- local default_options = { noremap=true, silent=true, buffer = bufnr, remap = false}
  local default_options = { noremap=true, silent=true, remap = false}
  return vim.tbl_extend('force', default_options, options)
end

function M.keymaps()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end
      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinitions')
      map('gsd', vim.lsp.buf.definition, 'Go definition (Second)')

      -- Find references for the word under your cursor.
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gsr', vim.lsp.buf.references, 'Go References (Second)')

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('gsI', vim.lsp.buf.implementation, 'LSP Implementation (Second)')

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
      map('<leader>vws', vim.lsp.buf.workspace_symbol, 'Workspace symbol')
      map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace symbol')
      map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace symbol')
      map('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end , 'List workspace folders')

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      vim.keymap.set('n', "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, {expr = true, desc = "LSP: Inc [R]e[n]ame"})

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('L', vim.lsp.buf.signature_help, 'Signature help')

      map('<leader>ftt', vim.lsp.buf.format, 'Format')
      map('<leader>gf', function() vim.lsp.buf.format({async = true}) end, 'Format async')

      map('<leader>le','<cmd>:!sh > ~/.local/state/nvim/lsp.log<CR>' , 'Empty lsp.log')
      map('<leader><leader>', function() vim.diagnostic.open_float(nil, { focus = false }) end, 'Open diag window' )


      local client = vim.lsp.get_client_by_id(event.data.client_id)
      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end

    end})
end

function M.diagnostic_keymaps()
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, optiones({desc = 'LSP Goto prev'}))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, optiones({desc = 'LSP Goto next'}))
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, optiones({desc = 'Open diagnostic [Q]uickfix list'}))
end

return M
