--------------------------------------------------------------------------------
-- NvimTree setup
-- see :help nvim-tree-default-mappings for default mappings
--------------------------------------------------------------------------------
-- require("nvim-nonicons").setup({})
-- set cursorline by default so the current file is highlighted
vim.cmd("set cursorline")
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = false,
		side = "left",
	},
	renderer = {
		group_empty = true,
		add_trailing = true,
		-- icons = {
		-- 	glyphs = require("nvim-nonicons.extentions.nvim-tree").glyphs,
		-- },
		symlink_destination = false,
	},
	filters = {
		dotfiles = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	actions = {
		open_file = {
			window_picker = {
				enable = true,
			},
		},
	},
})
