local M = {}

M = {
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-emoji',
      --  Snipper : Use luasnip
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      --'hrsh7th/cmp-cmdline',
      --'hrsh7th/cmp-calc',
      --'f3fora/cmp-spell',
      "onsails/lspkind.nvim", -- vscodelike picto
    },
    config = function()
      require("features.completion").setup()
    end
  },{
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    }
  }
}

function M.setup()
  local cmp_status_ok, cmp = pcall(require, 'cmp')
  if not cmp_status_ok then
    return
  end

  local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
  if not luasnip_status_ok then
    return
  end

  -- doc: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
  -- snippets from https://github.com/honza/vim-snippets.git

  -- for friendly snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  -- for custom snippets
  -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snips" } })
  require("luasnip.loaders.from_snipmate").lazy_load { lazy_paths = "~/.config" .. "/snippets/vim-snippets/snippets" }
  -- require("luasnip.loaders.from_lua").lazy_load { paths = vim.fn.stdpath "config" .. "/lua/snippets" }

  local lspkind_status_ok, lspkind = pcall(require, 'lspkind')
  if not lspkind_status_ok then
    return
  end

  local border_opts = {
    border = "rounded",
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
  }

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    sources = {
      { name = "nvim_lsp", priority = 100 }, -- Keep LSP results on top.
      { name = 'luasnip', priority = 75 },
      { name = "path", priority = 50},
      { name = "emoji",
        option = {
          insert = true } },
      { name = 'nvim_lsp_signature_help' },
      { name = "spell" },
      { name = "treesitter" },
      { name = "nvim_lua" },
      { name = "buffer", priority = 1 }, -- Keep buffer words last
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      -- Tab mapping
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end
     },
    format = lspkind_status_ok and lspkind.cmp_format(lspkind) or nil,
    formatting = {
      format = lspkind.cmp_format({
        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol_text',
        -- mode = 'symbol', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function (entry, vim_item)
          -- set a name for each source
          vim_item.menu = ({
            buffer = "[Buffer]",
            emoji = "[Emoji]",
            nvim_lsp = "[LSP]",
            path = "[Path]",
            spell = "[Spell]",
            treesitter = "[Treesitter]",
            nvim_lua = "[Neovim]",
            luasnip = "[LuaSnip]",
            nvim_lsp_signature_help = "[Nvim Lsp Signature Help]"
          })[entry.source.name]
          return vim_item
        end
      })
    },
    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
  })
end

return M
