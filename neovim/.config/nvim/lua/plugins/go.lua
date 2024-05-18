return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			icons = { breakpoint = "🧘", currentpos = "🏃" }, -- setup to `false` to disable icons setup
			run_in_floaterm = true, -- set to true to run in float window. :GoTermClose closes the floatterm
			-- float term recommend if you use richgo/ginkgo with terminal color
			trouble = true, -- true: use trouble to open quickfix
			luasnip = true, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
			--  Do not enable this if you already added the path, that will duplicate the entries
		})
	end,
	-- event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
