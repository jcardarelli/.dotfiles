return {
	"norcalli/nvim-colorizer.lua",
	ft = { "lua", "html", "css", "javascript" },
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
			"typescript",
			"lua",
			html = {
				mode = "foreground",
			},
		})
	end,
}
