return {
	"kyazdani42/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	init = function()
		-- set cursorline by default so the current file is highlighted
		vim.cmd("set cursorline")
	end,
	cmd = "NvimTreeToggle",
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				adaptive_size = false,
				side = "left",
			},
			renderer = {
				group_empty = true,
				add_trailing = true,
				symlink_destination = false,
			},
			filters = {
				dotfiles = true,
			},
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
				update_root = true,
			},
			actions = {
				open_file = {
					window_picker = {
						enable = true,
					},
				},
			},
		})
	end,
}
