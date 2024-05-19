return {
	{
		"nvim-treesitter/playground",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-endwise",
		},
		config = function()
			--------------------------------------------------------------------------------
			-- treesitter setup
			--------------------------------------------------------------------------------
			-- indentation
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"bash",
					"javascript",
					"lua",
					"python",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				auto_install = true,
				highlight = {
					enable = true,
					-- https://www.reddit.com/r/neovim/comments/n9aupn/comment/gxmu5d7/?utm_source=share&utm_medium=web2x&context=3
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				-- Enable endwise plugin for closing if statements
				-- requires https://github.com/RRethy/nvim-treesitter-endwise
				endwise = {
					enable = true,
				},
				-- matchup.vim config for treesitter
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
					disable = {}, -- optional, list of language that will be disabled
				},
				-- expand selection to the next element in the code
				-- is this broken? seems pretty broken
				-- incremental_selection = {
				-- 	enable = true,
				-- 	keymaps = {
				-- 		init_selection = "<CR>",
				-- 		scope_incremental = "<CR>",
				-- 		node_incremental = "<TAB>",
				-- 		node_decremental = "<S-TAB>",
				-- 	},
				-- },
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>p"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>P"] = "@parameter.inner",
						},
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = { query = "@class.outer", desc = "Next class start" },

						-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
						["]o"] = "@loop.*",
						-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }

						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
					-- Below will go to either the start or the end, whichever is closer.
					-- Use if you want more granular movements
					-- Make it even more gradual by adding multiple queries and regex.
					goto_next = {
						["]d"] = "@conditional.outer",
					},
					goto_previous = {
						["[d"] = "@conditional.outer",
					},
				},
			})
		end,
		lazy = true,
	},
	{
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
	},
}
