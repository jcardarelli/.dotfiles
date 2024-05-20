-- Vim settings, package manager, and mappings
require("config.globals")
require("config.lazy")
require("config.mappings")

-- Display
require("config.theme")
require("config.todo-comments")
require("config.icons")

-- LSP and LSP-adjacent
require("config.lsp")
require("config.nvim-cmp")
require("config.mason")
