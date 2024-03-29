-- Vim settings, package manager, and mappings
require("config.globals")
require("config.lazy")
require("config.mappings")

-- Display and colors
require("config.theme")
require("config.nvim-tree")
require("config.todo-comments")
require("config.icons")

-- Window focus and terminal
require("config.focus")
require("config.toggleterm")

-- File and text search
require("config.telescope")
require("config.ack")

-- LSP and LSP-adjacent
require("config.lsp")
require("config.nvim-cmp")
require("config.mason")
require("config.dap")

-- Formatting
require("config.conform")

-- Language support
require("config.treesitter")
require("config.go")
require("config.terraform")
