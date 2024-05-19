return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	build = "make install_jsregexp",
	init = function()
		-- Use existing VS Code-style snippets from rafamadriz/friendly-snippets plugin
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
	},
}
