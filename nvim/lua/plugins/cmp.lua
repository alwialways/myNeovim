local cmp = require'cmp'
local lspkind = require('lspkind')
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      max_width = 20,
      menu = {
          buffer = "[BUF]",
          nvim_lsp = "[LSP]",
          snippet = "[Snippet]",
      },
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'git' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'luasnip', options = {use_show_condition = false} }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  require("cmp_git").setup()

  -- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
