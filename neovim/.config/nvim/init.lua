-- Vim settings, package manager, and mappings
require("config.globals")
require("config.lazy")
require("config.mappings")

-- Display
require("config.theme")
require("config.todo-comments")
require("config.icons")

-- Window focus and terminal
require("config.toggleterm")

-- LSP and LSP-adjacent
require("config.lsp")
require("config.nvim-cmp")
require("config.mason")

-- Formatting
require("config.conform")

-- Language support
require("config.treesitter")
