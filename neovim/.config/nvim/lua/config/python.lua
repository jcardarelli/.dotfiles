-- Activate venv automatically for python projects
-- https://github.com/linux-cultist/venv-selector.nvim/issues/96#issuecomment-2010242590
local augroup = vim.api.nvim_create_augroup("VenvSelectorRetrieve", { clear = true })
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	pattern = { "*.py" },
	group = augroup,
	callback = function(args)
		if vim.lsp.get_client_by_id(args["data"]["client_id"])["name"] == "pyright" then
			require("venv-selector").retrieve_from_cache()
			vim.api.nvim_del_augroup_by_id(augroup)
		end
	end,
})
