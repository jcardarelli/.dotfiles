--------------------------------------------------------------------------------
-- Replaced null-ls (RIP) with this plugin
--------------------------------------------------------------------------------
require("conform").setup({
	formatters_by_ft = {
		go = { "gofumpt", "goimports", "golines" },
		javascript = { { "prettierd", "prettier" } }, -- Use a sub-list to run only the first available formatter
		lua = { "stylua" },
		python = { "isort", "black" },
		terraform = { "terraform_fmt" },
		sh = { "shfmt" }
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

require("conform").formatters.shfmt = {
	inherit = false,
	command = "shfmt",
	args = { "-i", "2", "-filename", "$FILENAME" },
}
