return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter" },
	config = function()
		-- treesitter splitjoin plugin for splitting and joining long lines
		local tsj = require("treesj")

		--[[ configuration for languages ]]
		local langs = {
			bash = {},
		}

		tsj.setup({
			-- Use default keymaps
			-- (<space>m - toggle, <space>j - join, <space>s - split)
			use_default_keymaps = true,

			-- Node with syntax error will not be formatted
			check_syntax_error = true,

			-- If line after join will be longer than max value,
			-- node will not be formatted
			max_join_length = 120,

			-- hold|start|end:
			-- hold - cursor follows the node/place on which it was called
			-- start - cursor jumps to the first symbol of the node being formatted
			-- end - cursor jumps to the last symbol of the node being formatted
			cursor_behavior = "hold",

			-- Notify about possible problems or not
			notify = true,
			langs = langs,

			-- Use `dot` for repeat action
			dot_repeat = true,
		})
	end,
}
