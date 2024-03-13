--------------------------------------------------------------------------------
-- ack.vim
--------------------------------------------------------------------------------
-- https://webcache.googleusercontent.com/search?q=cache:HF6icfelcoIJ:https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/&cd=3&hl=en&ct=clnk&gl=us&client=firefox-b-1-d
-- Use ripgrep for searching ⚡️
-- Options include:
-- --vimgrep -> Needed to parse the rg response properly for ack.vim
-- --type-not sql -> Avoid huge sql file dumps as it slows down the search
-- --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
vim.g.ackprg = 'rg --vimgrep --type-not sql --smart-case --no-ignore-vcs -g "!{node_modules,.git}"'

-- Auto close the Quickfix list after pressing '<enter>' on a list item
vim.g.ack_autoclose = 1

-- Any empty ack search will search for the work the cursor is on
vim.g.ack_use_cword_for_empty_search = 1

-- Ack mappings
-- Don't jump to first match
vim.cmd("cnoreabbrev Ack Ack!")
-- Maps <Leader>/ so we're ready to type the search keyword
vim.cmd("nnoremap <Leader>a :Ack!<Space>")
