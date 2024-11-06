local formatters_by_ft = {
	css = { "prettier" },
	go = {
		"gofumpt",
		"goimports",
		"golines",
	},
	html = { "prettier" },
	java = { "google-java-format" },
	javascript = { "prettier" },
	lua = { "stylua" },
	python = {
		"autopep8",
		"black",
		"isort",
	},
	terraform = { "terraform_fmt" },
	sass = { "prettier" },
	sh = {
		"shellharden",
		"shfmt",
	},
	yaml = { "yamlfmt" },
}

local function table_keys(t)
	local keys = {}
	for k, _ in pairs(t) do
		table.insert(keys, k)
	end
	return keys
end

-- Get the list of filetypes from formatters_by_ft
local ft = table_keys(formatters_by_ft)

return {
	"stevearc/conform.nvim",
	opts = {},
	ft = ft,
	config = function()
		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
			format_on_save = {
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
