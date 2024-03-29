--------------------------------------------------------------------------------
-- Current theme settings
--------------------------------------------------------------------------------
require("tokyonight").setup({
	style = "storm",     -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = true,  -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark",                -- style for sidebars, see below
		floats = "dark",                  -- style for floating windows
	},
	sidebars = { "qf", "help", "NvimTree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3,                 -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = true,      -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false,                 -- dims inactive windows
	lualine_bold = false,                 -- When `true`, section headers in the lualine theme will be bold
	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	-- on_colors = function(colors)
	-- 	colors.bg_search = colors.fg_float
	-- end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	on_highlights = function(hl, c)
		hl.IndentBlanklineContextChar = {
			fg = c.dark5,
		}
		-- Borderless telescope from readme
		-- https://github.com/nvim-telescope/telescope.nvim/wiki/Gallery#borderless
		local prompt = "#2d3149"
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = prompt,
		}
		hl.TelescopePromptBorder = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePromptTitle = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
	end,

})

local TelescopePrompt = {
	TelescopePromptNormal = {
		bg = '#2d3149',
	},
	TelescopePromptBorder = {
		bg = '#2d3149',
	},
	TelescopePromptTitle = {
		fg = '#2d3149',
		bg = '#2d3149',
	},
	TelescopePreviewTitle = {
		fg = '#1F2335',
		bg = '#1F2335',
	},
	TelescopeResultsTitle = {
		fg = '#1F2335',
		bg = '#1F2335',
	},
}

for hl, col in pairs(TelescopePrompt) do
	vim.api.nvim_set_hl(0, hl, col)
end

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd([[colorscheme tokyonight]])


--------------------------------------------------------------------------------
-- lualine setup
--------------------------------------------------------------------------------
require("lualine").setup({
	options = {
		theme = "tokyonight",
		component_separators = "",
		disabled_filetypes = {
			"Lazy",
			"NvimTree",
			"sagaoutline",
			"toggleterm",
		},

		-- If current filetype is in this list it'll
		-- always be drawn as inactive statusline
		-- and the last window will be drawn as active statusline.
		-- for example if you don't want statusline of
		-- your file tree / sidebar window to have active
		-- statusline you can add their filetypes here.
		ignore_focus = {
			"dap-repl",
			"dapui_breakpoints",
			"dapui_console",
			"dapui_scopes",
			"dapui_stacks",
			"dapui_watches",
		}
	},
})


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
		buffer_close_icon = '󰅖',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',

	},
})


--------------------------------------------------------------------------------
-- gitsigns setup
--------------------------------------------------------------------------------
-- for tokyonight
vim.cmd([[:highlight GitSignsAdd guifg=#9ece6a]])
vim.cmd([[:highlight GitSignsChange guifg=#7aa2f7]])
vim.cmd([[:highlight GitSignsDelete guifg=#f7768e]])
require("gitsigns").setup({
	-- signs = {
	--   add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
	--   change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
	--   delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
	--   topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
	--   changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
	--   untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
	-- },
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = true,   -- Toggle with `:Gitsigns toggle_numhl`
	linehl = true,  -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = false,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = true,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, gs_opts)
			gs_opts = gs_opts or {}
			gs_opts.buffer = bufnr
			vim.keymap.set(mode, l, r, gs_opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map({ "n", "v" }, "<Leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<Leader>hr", ":Gitsigns reset_hunk<CR>")
		map("n", "<Leader>hS", gs.stage_buffer)
		map("n", "<Leader>hu", gs.undo_stage_hunk)
		map("n", "<Leader>hR", gs.reset_buffer)
		map("n", "<Leader>hp", gs.preview_hunk)
		map("n", "<Leader>hb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "<Leader>tb", gs.toggle_current_line_blame)
		map("n", "<Leader>hd", gs.diffthis)
		map("n", "<Leader>hD", function()
			gs.diffthis("~")
		end)
		map("n", "<Leader>td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
-- gitsigns integration for scrollbar.nvim
require("scrollbar.handlers.gitsigns").setup()


--------------------------------------------------------------------------------
-- Highlight RGB and hex colors
--------------------------------------------------------------------------------
-- https://github.com/norcalli/nvim-colorizer.lua#installation-and-usage
-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
	'css',
	'javascript',
	'lua',
	html = {
		mode = 'foreground',
	}
}


--------------------------------------------------------------------------------
-- setup scrollbar with tokyonight color support
--------------------------------------------------------------------------------
local colors = require("tokyonight.colors").setup()
require("scrollbar").setup({
	-- Hide the scrollbar if all lines in file are visible
	hide_if_all_visible = true,
	max_lines = 10000,
	handle = {
		-- for dark mode
		color = colors.blue0,
		-- for light mode
		-- color = colors.fg,
		hide_if_all_visible = true,
	},
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true, -- Requires gitsigns
		handle = true,
		search = true, -- Requires hlslens
		ale = false, -- Requires ALE
	},
	-- These settings will add dianostic symbols to the scrollbar -- I think
	-- having diagnostic symbols on the left side is enough?
	marks = {
		Search = { color = colors.orange },
		Error = { color = colors.error },
		Warn = { color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	},
})
