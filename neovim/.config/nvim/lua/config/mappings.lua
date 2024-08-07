local defaults = {
	noremap = true,
	silent = true,
}

-- General mappings
vim.keymap.set("n", "<Leader>ev", ":vsp $MYVIMRC<CR>", defaults)
vim.keymap.set("n", "<Leader>sv", ":source $MYVIMRC<CR>", defaults)
vim.keymap.set("n", "<Leader>ek", ":vsp $HOME/.config/kitty/kitty.conf<CR>", defaults)
vim.keymap.set("n", "<Leader>ep", ":vsp $HOME/.config/nvim/lua/plugins/<CR>", defaults)
vim.keymap.set("n", "<Leader>ef", ":vsp $HOME/.config/fish/config.fish<CR>", defaults)
vim.keymap.set("n", "<Leader>et", ":vsp $HOME/.config/tmux/tmux.conf<CR>", defaults)

-- Treesitter
vim.keymap.set("n", "<Leader>tsp", ":TSPlayground<CR>", defaults)

-- Lazy file operations
vim.keymap.set("n", "<Leader>w", ":write<CR>", defaults)

-- Turn off highlighted search with \\
vim.keymap.set("n", "\\\\", "<cmd>noh<CR>", defaults)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<Leader>fr", builtin.registers, {})
vim.keymap.set("n", "<Leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<Leader>fc", ":Easypick changed_files<CR>", defaults)
vim.keymap.set("n", "<Leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", defaults)
vim.keymap.set("n", "<Leader>fb", builtin.buffers, defaults)
vim.keymap.set("n", "<Leader>fh", builtin.help_tags, defaults)

-- Vimgrep
vim.keymap.set("n", "<Leader>vg", ":vimgrep <Space> %", defaults)

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-setup-and-configuration
-- require("telescope").load_extension("fzf")

-- Habitual update keymaps
vim.keymap.set("n", "<Leader>L", ":Lazy<CR>", defaults)
vim.keymap.set("n", "<Leader>M", ":Mason<CR>", defaults)
vim.keymap.set("n", "<Leader>Ts", ":TSUpdate<CR>", defaults)

-- NvimTree
vim.keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR><C-w>l", defaults)

-- Trouble
vim.keymap.set("n", "<Leader>T", ":Trouble diagnostics toggle<CR>", defaults)

-- Buffer mappings
vim.keymap.set("n", "<Leader>bf", ":bfirst<CR>", defaults)
vim.keymap.set("n", "<Leader>bl", ":blast<CR>", defaults)
vim.keymap.set("n", "<Leader>bn", ":bnext<CR>", defaults)
vim.keymap.set("n", "<Leader>bd", ":bd<CR>:bnext<CR>", defaults)
vim.keymap.set("n", "<Leader>bp", ":bprevious<CR>", defaults)
vim.keymap.set("n", "<Leader>tn", ":tabn<CR>", defaults)
vim.keymap.set("n", "<Leader>tp", ":tabp<CR>", defaults)
vim.keymap.set("n", "<Leader>o", ":only<CR>", defaults)
vim.keymap.set("n", "<Leader>h", ":hide<CR>", defaults)

-- toggleterm mappings
-- ungodly hack here to make the first execution of the terminal command auto-scroll
-- to the bottom since I can't get toggleterm's `auto_scroll` setting working.
vim.keymap.set(
	"n",
	"<Leader>gr",
	':TermExec cmd="go run %" direction=vertical size=84<CR><C-w>l<C-\\><C-n>G<C-w>h',
	defaults
)
vim.keymap.set(
	"n",
	"<Leader>gt",
	':TermExec cmd="go test %" direction=vertical size=84<CR><C-w>l<C-\\><C-n>G<C-w>h',
	defaults
)
vim.keymap.set("n", "<Leader>tc", ':TermExec cmd="exit"<CR>', defaults)
vim.keymap.set("n", "<C-\\>", ":ToggleTerm direction=vertical size=90<CR>", defaults)
vim.keymap.set("n", "<S-\\><C-\\>", ":ToggleTerm direction=horizontal size=90<CR>", defaults)

-- https://github.com/akinsho/toggleterm.nvim#terminal-window-mappings
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Git
-- mappings for using git in the built-in terminal
-- local diff_cmd = "PAGER= git diff " .. vim.api.nvim_buf_get_name(0) .. "<CR>"
-- vim.keymap.set("n", "<Leader>gd", builtin.help_tags, {})
vim.cmd('nnoremap <silent> <Leader>gd :TermExec cmd="PAGER= git diff"<CR>')
-- local lsp_filename = vim.api.nvim_buf_get_name(0)
vim.cmd('nnoremap <silent> <Leader>gdc :TermExec cmd="PAGER= git diff --cached"<CR>')
-- TODO: Also run git status in the terminal after adding the file
vim.keymap.set("n", "<Leader>ga", ":TermExec cmd='git add .; git status; echo; g10'<CR>", defaults)
vim.keymap.set("n", "<Leader>gc", ":Git commit -qm '", defaults)
vim.keymap.set("n", "<Leader>gg", ":Git", defaults)
-- Run git add and git commit --amend --no-edit. <Bar> or \| allow for running multiple commands as part of one mapping
vim.keymap.set("n", "<Leader>gmd", ":Git commit --amend --no-edit<CR>", defaults)
vim.keymap.set(
	"n",
	"<Leader>gmd",
	":TermExec cmd='git add %; git commit --amend --no-edit; echo; git status; echo; g10'<CR>",
	{ silent = false }
)
vim.keymap.set("n", "<Leader>gst", ":TermExec cmd='git status'<CR>")
vim.cmd('nnoremap <silent> <Leader>g10 :TermExec cmd="g10"<CR>')
vim.cmd("nnoremap <silent> <Leader>gp :TermExec cmd='git push'<CR>")

-- Exa
vim.cmd('nnoremap <silent> <Leader>ee :TermExec cmd="exa --long"<CR>')

-- regular terminal stuff
vim.cmd('nnoremap <silent> <Leader>l :TermExec cmd="clear"<CR>')
vim.keymap.set("n", "<Leader>lq", ":TermExec cmd='q'<CR>", defaults)
vim.keymap.set("n", "<Leader>rl", ":w <bar> :TermExec cmd='!!' <CR>", defaults)
vim.keymap.set("n", "<Leader>r2l", ":w <bar> :TermExec cmd='!2' <CR>", defaults)
vim.keymap.set("n", "<Leader>gR", ":GoRun<CR><C-w>h", defaults)
vim.keymap.set("n", "<Leader>tC", ":GoTermClose<CR>", defaults)

-- mapping for inserting the current filename into the buffer
vim.keymap.set("n", "<Leader>fn", ":put =expand('%')<CR>", defaults)

-- currently disabled
-- ts-node-action mappings for compacting & expanding code with treesitter
-- vim.keymap.set({ "n" }, "<Leader>k", require("ts-node-action").node_action, { desc = "Trigger Node Action" })

-- bring function to the top when browsing with [[ or ]]
vim.keymap.set("n", "<Leader>[", "zt", defaults)

-- run the markdown previewer in a local browser window
vim.keymap.set("n", "<Leader>mdp", ":MarkdownPreview<CR>", defaults)

-- emacs keybindings for command mode
-- go to start of line
vim.cmd("cnoremap <C-A> <Home>")
-- go to end of line
vim.cmd("cnoremap <C-E> <End>")
-- go back one character
vim.cmd("cnoremap <C-B> <Left>")
-- delete character under cursor
vim.cmd("cnoremap <C-D> <Del>")
-- go forward one character
-- vim.cmd 'cnoremap <C-F> <Right>'
-- recall newer command-line
vim.cmd("cnoremap <C-N> <Down>")
-- recall previous (older) command-line
-- Does this break telescope?
-- vim.cmd("cnoremap <C-P> <Up>")
-- go back one word
vim.cmd("cnoremap <M-b> <S-Left>")
-- go forward one word
vim.cmd("cnoremap <M-f> <S-Right>")
-- delete one word
vim.cmd("cnoremap <M-Bs> <C-W>")

-- quickfix tpope unimpaired additions
vim.keymap.set("n", "\\q", "<cmd>cclose<CR>", defaults)

-- DAP debugger
vim.keymap.set("n", "<Leader>dc", require("dap").continue)
vim.keymap.set("n", "<Leader>do", require("dap").step_over)
vim.keymap.set("n", "<Leader>di", require("dap").step_into)
vim.keymap.set("n", "<Leader>dou", require("dap").step_out)
vim.keymap.set("n", "<Leader>db", require("dap").toggle_breakpoint)

-- Show nice result counts as inline text with *, #, n, N, etc. (e.g. 1/4)
require("hlslens").setup()
vim.api.nvim_set_keymap(
	"n",
	"n",
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	defaults
)
vim.api.nvim_set_keymap(
	"n",
	"N",
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	defaults
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], defaults)
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], defaults)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], defaults)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], defaults)

-- Jump to TODO HACK WARN PERF NOTE TEST comments
local keywords_list = {
	"TODO",
	"HACK",
	"WARN",
	"PERF",
	"NOTE",
	"TEST",
}
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next({ keywords = keywords_list })
end, { desc = "Next error/warning todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev({ keywords = keywords_list })
end, { desc = "Previous error/warning todo comment" })

-- Toggle LSP diagnostics
-- https://www.reddit.com/r/neovim/comments/uri2p4/here_is_a_quick_code_snippet_to_toggle_lsp/
local diagnostics_active = true
vim.keymap.set("n", "<Leader>d", function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end)

--------------------------------------------------------------------------------
-- boole.nvim increment/decrement extension plugin settings
-- much simpler than dial.nvim (and seemingly more stable since boolean switching works)
--------------------------------------------------------------------------------
require("boole").setup({
	mappings = {
		increment = "<C-a>",
		decrement = "<C-x>",
	},
})

-- Neogen
vim.api.nvim_set_keymap("n", "<Leader>nt", ":Neogen type<CR>", defaults)
vim.api.nvim_set_keymap("n", "<Leader>nF", ":Neogen file<CR>", defaults)
vim.api.nvim_set_keymap("n", "<Leader>nc", ":Neogen class<CR>", defaults)
vim.api.nvim_set_keymap("n", "<Leader>nf", ":Neogen func<CR>", defaults)

-- Treesitter-based split join plugin
vim.keymap.set("n", "<Leader>sj", ":lua require('treesj').toggle()<CR>", defaults)
vim.keymap.set("v", "<Leader>sj", ":lua require('treesj').toggle()<CR>", defaults)
