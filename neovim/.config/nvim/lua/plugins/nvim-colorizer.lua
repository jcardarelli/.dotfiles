return {
	"norcalli/nvim-colorizer.lua",
	ft = {
		"css",
		"html",
		"javascript",
		"lua",
		"sass",
	},
	config = function()
		--------------------------------------------------------------------------------
		-- Highlight RGB and hex colors
		--------------------------------------------------------------------------------
		-- https://github.com/norcalli/nvim-colorizer.lua#installation-and-usage
		-- Attach to certain Filetypes, add special configuration for `html`
		-- Use `background` for everything else.
		require("colorizer").setup({
			"css",
			"gitconfig",
			"javascript",
			"lua",
			"sass",
			"typescript",
			html = {
				mode = "foreground",
			},
		})
	end,
}
