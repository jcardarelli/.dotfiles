--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------
-- Insert mode mappings
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })

-- General mappings
vim.keymap.set("n", "<Leader>ev", ":vsp $MYVIMRC<CR>", { silent = true })
vim.keymap.set("n", "<Leader>sv", ":source $MYVIMRC<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ek", ":vsp $HOME/.config/kitty/kitty.conf<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ep", ":vsp /Users/jcard/.config/nvim/lua/plugins/<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ef", ":vsp $HOME/.config/fish/config.fish<CR>", { silent = true })
-- there's no way this will actually work as written?
-- vim.keymap.set("n", "<Leader>sf", ":source $HOME/.config/fish/config.fish<CR>", { silent = true })
vim.keymap.set("n", "<Leader>et", ":vsp $HOME/.config/tmux/tmux.conf<CR>", { silent = true })

-- TODO, etc.
vim.keymap.set("n", "<Leader>todo", "iTODO:<Esc>gcc", { silent = true }) --broken
vim.cmd('ab Todo // TODO:')
vim.cmd('ab Warn // WARN:')
vim.cmd('ab Hack // HACK:')
vim.cmd('ab Perf // PERF:')
vim.cmd('ab Note // NOTE:')
vim.cmd('ab Test // Test:')

-- Treesitter
vim.cmd("nnoremap <silent> <Leader>tsp :TSPlayground<CR>") -- edit plugins

-- Lazy file operations
vim.keymap.set("n", "<Leader>w", ":write<CR>", { silent = true })

-- Turn off highlighted search with \\
vim.keymap.set("n", "\\\\", "<cmd>noh<CR>", { silent = true })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<Leader>fc", ":Easypick changed_files<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ silent = true })
vim.keymap.set("n", "<Leader>fb", builtin.buffers, { silent = true })
vim.keymap.set("n", "<Leader>fh", builtin.help_tags, { silent = true })

-- Vimgrep
vim.keymap.set("n", "<Leader>vg", ":vimgrep <Space> %", { silent = true })

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-setup-and-configuration
-- require("telescope").load_extension("fzf")
-- Lazy
-- vim.keymap.set("n", "<Leader>L", ":Lazy<CR>", { silent = true })

-- NvimTree
vim.cmd("nnoremap <Leader>t :NvimTreeToggle<CR>")

-- Trouble
vim.cmd("nnoremap <Leader>T :TroubleToggle<CR>")

-- Buffer mappings
vim.cmd("nnoremap <silent> <Leader>bf :bfirst<CR>")
vim.cmd("nnoremap <silent> <Leader>bl :blast<CR>")
vim.cmd("nnoremap <silent> <Leader>bn :bnext<CR>")
vim.cmd("nnoremap <silent> <Leader>bd :bd<CR>:bnext<CR>")
vim.cmd("nnoremap <silent> <Leader>bp :bprevious<CR>")
vim.cmd("nnoremap <silent> <Leader>tn :tabn<CR>")
vim.cmd("nnoremap <silent> <Leader>tp :tabp<CR>")
vim.cmd("nnoremap <silent> <Leader>o :only<CR>")
vim.cmd("nnoremap <silent> <Leader>h :hide<CR>")

-- toggleterm mappings
-- Go plugin close floating terminal
-- ungodly hack here to make the first execution of the terminal command auto-scroll
-- to the bottom since I can't get toggleterm's `auto_scroll` setting working.
vim.cmd('nnoremap <silent> <Leader>gr :TermExec cmd="go run %" direction=vertical size=84<CR><C-w>l<C-\\><C-n>G<C-w>h')
vim.cmd('nnoremap <silent> <Leader>gt :TermExec cmd="go test %" direction=vertical size=84<CR><C-w>l<C-\\><C-n>G<C-w>h')
vim.cmd('nnoremap <silent> <Leader>tc :TermExec cmd="exit"<CR>')
vim.cmd("nnoremap <silent> <C-\\> :ToggleTerm direction=vertical size=84<CR>")
vim.cmd("nnoremap <silent> <S-\\><C-\\> :ToggleTerm direction=horizontal size=90<CR>")

-- https://github.com/akinsho/toggleterm.nvim#terminal-window-mappings
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
	-- this one is excluded so that Ctrl+l (clear) works as expected while in the terminal window
	-- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Git
-- mappings for using git in the built-in terminal
-- local diff_cmd = "PAGER= git diff " .. vim.api.nvim_buf_get_name(0) .. "<CR>"
-- vim.keymap.set("n", "<Leader>gd", builtin.help_tags, {})
vim.cmd('nnoremap <silent> <Leader>gd :TermExec cmd="PAGER= git diff"<CR>')
-- local lsp_filename = vim.api.nvim_buf_get_name(0)
vim.cmd('nnoremap <silent> <Leader>gdc :TermExec cmd="PAGER= git diff --cached"<CR>')
-- TODO: Also run git status in the terminal after adding the file
-- vim.cmd("nnoremap <Leader>ga :Git add %<CR>")
vim.keymap.set("n", "<Leader>ga", ":TermExec cmd='git add .; git status; echo; g10'<CR>", { silent = true })
vim.cmd("nnoremap <silent> <Leader>gc :Git commit -m '")
-- Run git add and git commit --amend --no-edit. <Bar> or \| allow for running multiple commands as part of one mapping
-- vim.cmd("nnoremap <Leader>gmd :Git add %<CR> <bar> :Git commit --amend --no-edit<CR>")
vim.keymap.set(
	"n",
	"<Leader>gmd",
	":TermExec cmd='git add %; git commit --amend --no-edit; echo; git status; echo; g10'<CR>",
	{ silent = false }
)
vim.cmd('nnoremap <silent> <Leader>gst :TermExec cmd="git status"<CR>')
vim.cmd('nnoremap <silent> <Leader>g10 :TermExec cmd="g10"<CR>')
vim.cmd('nnoremap <silent> <Leader>gp :TermExec cmd="git push"<CR>')

-- Exa
vim.cmd('nnoremap <silent> <Leader>ee :TermExec cmd="exa --long"<CR>')

-- regular terminal stuff
vim.cmd('nnoremap <silent> <Leader>l :TermExec cmd="clear"<CR>')
vim.cmd("nnoremap <silent> <Leader>rl :w <bar> :TermExec cmd='!!' <CR>")
-- vim.cmd("nnoremap <Leader>gr :vsplit <Bar> terminal go run %<CR><C-w>h")
vim.cmd("nnoremap <silent> <Leader>gR :GoRun<CR><C-w>h")
vim.cmd("nnoremap <silent> <Leader>tC :GoTermClose<CR>")

-- mapping for inserting the current filename into the buffer
vim.cmd("nnoremap <silent> <Leader>fn :put =expand('%')<CR>")

-- currently disabled
-- ts-node-action mappings for compacting & expanding code with treesitter
-- vim.keymap.set({ "n" }, "<Leader>k", require("ts-node-action").node_action, { desc = "Trigger Node Action" })

-- bring function to the top when browsing with [[ or ]]
vim.cmd("nnoremap <Leader>[ zt")

-- run the markdown previewer in a local browser window
vim.cmd("nnoremap <Leader>mdp :MarkdownPreview<CR>")

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
vim.keymap.set("n", "\\q", "<cmd>cclose<CR>", { silent = true })

-- DAP debugger
vim.keymap.set("n", "<Leader>dc", require("dap").continue)
vim.keymap.set("n", "<Leader>do", require("dap").step_over)
vim.keymap.set("n", "<Leader>di", require("dap").step_into)
vim.keymap.set("n", "<Leader>dou", require("dap").step_out)
vim.keymap.set("n", "<Leader>db", require("dap").toggle_breakpoint)

-- Show nice result counts as inline text with *, #, n, N, etc. (e.g. 1/4)
require("hlslens").setup()
local kopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
	"n",
	"n",
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts
)
vim.api.nvim_set_keymap(
	"n",
	"N",
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

-- Jump to TODO HACK WARN PERF NOTE TEST comments
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next({ keywords = { "TODO", "HACK", "WARN", "PERF", "NOTE", "TEST" } })
end, { desc = "Next error/warning todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev({ keywords = { "TODO", "HACK", "WARN", "PERF", "NOTE", "TEST" } })
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
