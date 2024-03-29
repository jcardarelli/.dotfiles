return {
	'nvimdev/lspsaga.nvim',
	config = function()
		require('lspsaga').setup({
			border_style = "rounded",
			diagnostic_header = { " ", " ", " ", "ﴞ " },
			hover = {
				max_width = 0.4, -- defines float window width
				max_height = 0.5, -- defines float window height
				open_link = 'gx', -- key for opening links
				open_cmd = '!chrome', -- cmd for opening links
			},
			lightbulb = {
				sign = false,
				virtual_text = true,
			},
			ui = {
				devicon = true,
			}
		})
	end,
	event = 'LspAttach',
	dependencies = {
		'nvim-treesitter/nvim-treesitter', -- optional
		'nvim-tree/nvim-web-devicons' -- optional
	}
}
