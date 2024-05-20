return {
	"petertriho/nvim-scrollbar",
	config = function()
		-- setup scrollbar with tokyonight color support
		local colors = require("tokyonight.colors").setup()

		require("scrollbar").setup({
			-- Hide the scrollbar if all lines in file are visible
			hide_if_all_visible = true,
			max_lines = 10000,
			handle = {
				-- for dark mode
				color = colors.blue0,
				-- for light mode
				-- color = colors.fg,
				hide_if_all_visible = true,
			},
			handlers = {
				cursor = true,
				diagnostic = true,
				gitsigns = true, -- Requires gitsigns
				handle = true,
				search = true, -- Requires hlslens
				ale = false, -- Requires ALE
			},
			-- These settings will add dianostic symbols to the scrollbar -- I think
			-- having diagnostic symbols on the left side is enough?
			marks = {
				Search = { color = colors.orange },
				Error = { color = colors.error },
				Warn = { color = colors.warning },
				Info = { color = colors.info },
				Hint = { color = colors.hint },
				Misc = { color = colors.purple },
			},
		})
	end,
}
