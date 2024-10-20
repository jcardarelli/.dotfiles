return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			-- gitsigns: Ignoring invalid configuration field 'yadm'
			-- yadm = {
			-- 	enable = false,
			-- },
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, gs_opts)
					gs_opts = gs_opts or {}
					gs_opts.buffer = bufnr
					vim.keymap.set(mode, l, r, gs_opts)
				end

				-- Don't attach to specific buffers whose name matches a pattern
				if
					vim.api.nvim_buf_get_name(bufnr):match("lazy")
					or vim.api.nvim_buf_get_name(bufnr):match("neoterm")
					or vim.api.nvim_buf_get_name(bufnr):match("noice")
					or vim.api.nvim_buf_get_name(bufnr):match("CHADtree")
					or vim.api.nvim_buf_get_name(bufnr):match("sagaoutline")
				then
					return false
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map("n", "<Leader>hs", gs.stage_hunk)
				map("n", "<Leader>hr", gs.reset_hunk)
				map("n", "<Leader>hS", gs.stage_buffer)
				map("n", "<Leader>hu", gs.undo_stage_hunk)
				map("n", "<Leader>hR", gs.reset_buffer)
				map("n", "<Leader>hp", gs.preview_hunk)
				map("n", "<Leader>hb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<Leader>tb", gs.toggle_current_line_blame)
				map("n", "<Leader>hd", gs.diffthis)
				map("n", "<Leader>hD", function()
					gs.diffthis("~")
				end)
				map("n", "<Leader>td", gs.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
		-- gitsigns integration for scrollbar.nvim
		require("scrollbar.handlers.gitsigns").setup()
	end,
}
