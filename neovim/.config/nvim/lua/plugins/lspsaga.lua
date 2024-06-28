return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			border_style = "rounded",
			code_action = {
				extend_gitsigns = true,
			},
			diagnostic_header = { " ", " ", " ", "ﴞ " },
			hover = {
				max_width = 0.4, -- defines float window width
				max_height = 0.5, -- defines float window height
				open_link = "gx", -- key for opening links
				open_cmd = "!chrome", -- cmd for opening links
			},
			lightbulb = {
				sign = true,
				virtual_text = false,
			},
			symbol_in_winbar = {
				enable = false,
			},
			ui = {
				devicon = true,
			},
		})
	end,
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
