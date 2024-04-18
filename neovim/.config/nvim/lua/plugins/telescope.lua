return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"andrew-george/telescope-themes",
		config = function()
			require("telescope").load_extension("themes")
		end,
	},
	{
		"axkirillov/easypick.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
	},
}
