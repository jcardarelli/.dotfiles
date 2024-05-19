return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "yamatsum/nvim-nonicons" },
		},
		cmd = { "Telescope" },
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						mime_hook = function(filepath, bufnr, opts)
							local is_image = function(filepath)
								local image_extensions = { "png", "jpg" } -- Supported image formats
								local split_path = vim.split(filepath:lower(), ".", { plain = true })
								local extension = split_path[#split_path]
								return vim.tbl_contains(image_extensions, extension)
							end
							if is_image(filepath) then
								local term = vim.api.nvim_open_term(bufnr, {})
								local function send_output(_, data, _)
									for _, d in ipairs(data) do
										vim.api.nvim_chan_send(term, d .. "\r\n")
									end
								end

								vim.fn.jobstart({
									"catimg",
									filepath, -- Terminal image viewer command
								}, { on_stdout = send_output, stdout_buffered = true })
							else
								require("telescope.previewers.utils").set_preview_message(
									bufnr,
									opts.winid,
									"Binary cannot be previewed"
								)
							end
						end,
					},
					-- non-icons plugin config
					prompt_prefix = "  " .. require("nvim-nonicons").get("telescope") .. "  ",
					selection_caret = " ❯ ",
					entry_prefix = "   ",
				},
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = {
							-- extend mappings
							i = {
								["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
								["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({
									postfix = " --iglob ",
								}),
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
				},
			})
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"axkirillov/easypick.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			--------------------------------------------------------------------------------
			-- Telescope picker config
			--------------------------------------------------------------------------------
			local easypick = require("easypick")
			-- TODO: See if we can get the base branch name from GitSigns.nvim
			local base_branch = "master"

			easypick.setup({
				pickers = {
					-- diff current branch with base_branch and show files that changed with respective diffs in preview
					{
						name = "changed_files",
						command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
						previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
					},
					-- list files that have conflicts with diffs in preview
					{
						name = "conflicts",
						command = "git diff --name-only --diff-filter=U --relative",
						previewer = easypick.previewers.file_diff(),
					},
				},
			})
		end,
	},
}
