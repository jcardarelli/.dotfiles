--------------------------------------------------------------------------------
-- Current theme settings
--------------------------------------------------------------------------------
require("tokyonight").setup({
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help", "NvimTree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
})

vim.opt.termguicolors = true
vim.opt.background = "dark"
-- https://github.com/neovim/neovim/issues/18201#issuecomment-1382075049
vim.api.nvim_cmd({
	cmd = "colorscheme",
	args = { "tokyonight" },
}, {})

--------------------------------------------------------------------------------
-- Buffer tab bars
--------------------------------------------------------------------------------
require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				highlight = "Directory",
				separator = true,
				text = "",
				text_align = "left",
			},
		},
		always_show_bufferline = true,
		separator_style = "thin",
		numbers = "buffer_id",
		-- indicator icons
		show_tab_indicators = true,
		buffer_close_icon = "󰅖",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
	},
})
