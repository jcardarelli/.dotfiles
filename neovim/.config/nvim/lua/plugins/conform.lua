-- conform replaces null-ls for formatting different languages
return {
	"stevearc/conform.nvim",
	opts = {},
	ft = { "css", "go", "html", "javascript", "lua", "python", "terraform", "sh", "yaml" },
	config = function()
		-- Replaced null-ls (RIP) with this plugin
		require("conform").setup({
			formatters_by_ft = {
				css = { "stylelint" },
				go = { "gofumpt", "goimports", "golines" },
				html = { "htmlbeautifier" },
				javascript = { "prettierd", "prettier" },
				lua = { "stylua" },
				python = { "isort", "black", "pydocstyle" },
				terraform = { "terraform_fmt" },
				sh = { "shellcheck", "shfmt" },
				yaml = { "yamlfmt" },
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
	end,
}
