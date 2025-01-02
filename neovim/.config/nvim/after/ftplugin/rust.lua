local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

vim.keymap.set(
	"n",
	"J", -- Override Neovim's built-in join lines keymap with rustaceanvim's vim.cmd.RustLsp('joinLines')
	function()
		vim.cmd.RustLsp("joinLines")
	end,
	{ silent = true, buffer = bufnr }
)
