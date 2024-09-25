return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	init = function()
		require("ibl").setup()
	end,
	opts = {},
}
