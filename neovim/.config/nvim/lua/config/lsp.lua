vim.diagnostic.config({
	float = { border = "rounded" },
})
-- Change border of documentation hover window: https://github.com/neovim/neovim/pull/13998
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

--------------------------------------------------------------------------------
-- LSP configuration
--------------------------------------------------------------------------------
-- Mappings for navigating LSP diagnostic messages
local opts = { noremap = true, silent = true }
vim.keymap.set("n", ">e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<Leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", bufopts)
	vim.keymap.set("n", "gr", "<Cmd>Lspsaga finder<cr>", opts)

	-- Lspsaga overrides for the default LSP
	vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	vim.keymap.set("n", "<C-p>", "<Cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<cr>", opts)
	vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<cr>", opts)
	vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<cr>", opts)
	vim.keymap.set("n", "<Leader>ol", "<Cmd>Lspsaga outline<cr>", opts)
	vim.keymap.set("n", "<Leader>ca", "<Cmd>Lspsaga code_action<cr>", opts)

	-- Server capabilities spec:
	-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorHold", {
			-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
			callback = function()
				local callbackOpts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = " ",
					scope = "cursor",
				}
				vim.diagnostic.open_float(nil, callbackOpts)
			end,
			-- callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- for gopls snippet support
capabilities.textDocument.completion.completionItem.snippetSupport = true

--------------------------------------------------------------------------------
-- nvim-lspconfig setup
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

lspconfig.ansiblels.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

if not configs.fishls then
	configs.fishls = {
		default_config = {
			cmd = { "fish-lsp", "start" },
			root_dir = lspconfig.util.root_pattern(".git"),
			filetypes = { "fish" },
		},
	}
end
lspconfig.fishls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.gopls.setup({
	cmd = { "gopls" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			-- for postfix snippets and analyzers
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
		init_options = {
			usePlaceholders = true,
		},
	},
})

lspconfig.groovyls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"java",
		"-jar",
		vim.fn.expand(
			"$HOME/.local/share/nvim/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar"
		),
	},
	filetypes = {
		"groovy",
	},
	settings = {
		groovy = {
			classpath = {
				vim.fn.expand("$HOME/code/groovy-tools/vars/"),
			},
		},
	},
})

lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Lua LSP config that alows vim as a global variable
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- avoids deprecation warning in lsp messages:
				-- https://www.reddit.com/r/neovim/comments/syjqdp/comment/hxy7upc/?utm_source=share&utm_medium=web2x&context=3
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = {
					"border",
					"os",
					"vim",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files,
				-- see also https://github.com/sumneko/lua-language-server/wiki/Libraries#link-to-workspace .
				-- Lua-dev.nvim also has similar settings for sumneko lua, https://github.com/folke/lua-dev.nvim/blob/main/lua/lua-dev/sumneko.lua
				library = {
					-- vim.fn.stdpath("data") .. "/site/pack/packer/opt/emmylua-nvim",
					vim.fn.stdpath("config"),
				},
				maxPreload = 2000,
				preloadFileSize = 50000,
				-- disable message: "Do you need to configure your work environment as luv?"
				-- https://github.com/LunarVim/LunarVim/issues/4049#issuecomment-1634539474
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- python
lspconfig.jedi_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
lspconfig.basedpyright.setup({
	-- Use jedi and pyright for python together
	-- https://www.reddit.com/r/neovim/comments/vpg72u/comment/ielb3h8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
	on_attach = function(client)
		client.server_capabilities.completionProvider = false
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.rename = false
		client.server_capabilities.signature_help = false
	end,
	capabilities = capabilities,
	settings = {
		pyright = { autoImportCompletion = true },
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
			},
		},
	},
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.terraformls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			-- Disable the "Wrong ordering of key "your_key" in mapping" warning message
			keyOrdering = false,
		},
	},
})

-- Enable signcolumn icons for nvim-lspconfig
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
