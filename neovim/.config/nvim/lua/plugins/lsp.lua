return {
	"neovim/nvim-lspconfig",
	"onsails/lspkind.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		init = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
			-- mason-lspconfig bridges Mason and vim.lsp.config
			-- It ensures Mason-installed servers are available to vim.lsp.enable()
			require("mason-lspconfig").setup({
				-- Automatically install servers configured via vim.lsp.config
				automatic_installation = true,
			})
		end,
		build = ":MasonUpdate",
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("fidget").setup({})
		end,
	},
	lazy = false,
}
