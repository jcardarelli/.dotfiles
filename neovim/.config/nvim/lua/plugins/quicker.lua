return {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	opts = {},
	config = function()
		require("quicker").setup()
	end,
}
