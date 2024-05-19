return {
	-- Neovim LSP setup
	"kevinhwang91/nvim-hlslens",
	"neovim/nvim-lspconfig",
	"onsails/lspkind.nvim",
	"williamboman/mason-lspconfig.nvim",
	"williamboman/nvim-lsp-installer",
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	},
	{
		"j-hui/fidget.nvim",
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
