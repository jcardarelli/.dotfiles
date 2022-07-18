require('plugins')

--------------------------------------------------------------------------------
-- LSP configuration
--------------------------------------------------------------------------------
require("nvim-lsp-installer").setup()
local lspconfig = require("lspconfig")
lspconfig.gopls.setup{
	cmd = {'gopls'},
	-- for postfix snippets and analyzers
	capabilities = capabilities,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	on_attach = on_attach,
}
lspconfig.dockerls.setup{}
lspconfig.bashls.setup{}
-- lspconfig.efm.setup {
--     init_options = {documentFormatting = true},
--     settings = {
--         rootMarkers = {".git/"},
--         languages = {
--             lua = {
--                 {formatCommand = "lua-format -i", formatStdin = true}
--             }
--         }
--     }
-- }

-- Lua LSP config that alows vim as a global variable
lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

--------------------------------------------------------------------------------
-- Setup nvim-cmp.
--------------------------------------------------------------------------------
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('snippy').expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

--------------------------------------------------------------------------------
-- Enable lualine
--------------------------------------------------------------------------------
require('lualine').setup {
	options = {
		theme = "catppuccin"
	}
}

-- set colorscheme
-- vim.cmd 'colorscheme duckbones'
-- vim.g.background = "dark"
-- vim.g.material_style = "oceanic"
-- vim.cmd 'colorscheme duskfox'
vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
vim.cmd[[colorscheme catppuccin]]

--------------------------------------------------------------------------------
-- Treesitter setup
--------------------------------------------------------------------------------
-- indentation
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
-- folding
-- vim.g.foldmethod = "expr"
-- vim.g.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd 'set foldmethod=expr'
vim.cmd 'set foldexpr=nvim_treesitter#foldexpr()'

--------------------------------------------------------------------------------
-- nvim tree setup
--------------------------------------------------------------------------------
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

--------------------------------------------------------------------------------
-- Golang plugin
--------------------------------------------------------------------------------
require('go').setup()
-- Run gofmt on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)
-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
vim.cmd 'set number'
vim.cmd 'set relativenumber'

--------------------------------------------------------------------------------
-- indent-blankline config
--------------------------------------------------------------------------------
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
