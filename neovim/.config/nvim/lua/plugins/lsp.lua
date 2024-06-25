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
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({})
		end,
		build = ":MasonUpdate",
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("fidget").setup({})
		end,
		opts = {
			integration = {
				["nvim-tree"] = {
					enable = true,
				},
			},
		},
	},
	lazy = false,
}
