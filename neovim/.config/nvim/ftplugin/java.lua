local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- BitInByte: Neovim | Set up Java with native LSP
-- https://www.youtube.com/watch?v=94IU4cBdhfM
-- -javaagent fixes lombok: https://www.reddit.com/r/neovim/comments/wpsorn/adding_lombok_to_neovim/ikmag6j/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.level=ALL",
		"-noverify",
		"-Xmx1G",
		"--add-modules=ALL-SYSTEM",
		"--add-opens", "java.base/java.util=ALL-UNNAMED",
		"--add-opens", "java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. vim.fn.expand("$HOME/java/lombok.jar"),
		"-jar", vim.fn.expand(
		"$HOME/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx_1.2.900.v20240129-1338.jar"),
		"-configuration", vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/config_mac/"),
		"-data", vim.fn.expand("~/.cache/jdtls/") .. workspace_dir,
	},
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
	capabilities = capabilities,
}

local bufopts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader>crv", ":lua require('jdtls').extract_variable()<CR>", { silent = true })
-- nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
-- nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
--
-- vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
-- nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
-- vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
-- vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
--
-- " If using nvim-dap
-- " This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
-- nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
-- nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>

-- Redefine keymaps for jdtls because this is required? Can I call the existing
-- keymaps in the lsp on_attach in init.lua?
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set("n", "<Leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts)
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
-- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

-- I want to use lspsaga, but the formatting is really weird for java
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', bufopts)
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', bufopts)
vim.keymap.set('n', '<C-p>', '<Cmd>Lspsaga diagnostic_jump_prev<cr>', bufopts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<cr>', bufopts)
vim.keymap.set('n', '<Leader>ol', '<Cmd>Lspsaga outline<cr>', bufopts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', bufopts)
-- vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<cr>', bufopts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<cr>', bufopts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga finder<cr>', bufopts)

require("jdtls").start_or_attach(config)
