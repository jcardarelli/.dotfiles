local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--------------------------------------------------------------------------------
-- Luasnip
-- Use existing VS Code-style snippets from rafamadriz/friendly-snippets plugin
--------------------------------------------------------------------------------
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

--------------------------------------------------------------------------------
-- Setup nvim-cmp
--------------------------------------------------------------------------------
local cmp = require("cmp")
-- local lspkind = require("lspkind")
cmp.setup({
	enabled = function()
		-- Disable nvim-cmp in Telescope's buffer
		-- https://www.reddit.com/r/neovim/comments/vtw4vl/disable_nvimcmp_in_telescopes_buffer/
		if vim.bo.buftype == "prompt" then
			return false
		end
		-- Disable completion in comments
		-- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#disabling-completion-in-certain-contexts-such-as-comments
		local context = require("cmp.config.context")
		-- Keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	-- enable borders for nvim-cmp to match lspsaga
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	-- commented out on 2024-04-13
	-- do I need this?
	-- formatting = {
	-- 	format = lspkind.cmp_format({
	-- 		mode = "symbol_text", -- show symbol and text annotations
	-- 		maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
	-- 		ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
	-- 		-- The function below will be called before any actual modifications from lspkind
	-- 		-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
	-- 		before = function(entry, vim_item)
	-- 			return vim_item
	-- 		end,
	-- 	}),
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		-- disabling this removes the duplicate signature when in insert mode
		-- on something.append([here])
		-- { name = "nvim_lsp_signature_help" },
		{
			name = "spell",
			option = {
				keep_all_entries = false,
				enable_in_context = function()
					return true
				end,
			},
		},
	}, {
		{ name = "buffer" },
	}),
})

--------------------------------------------------------------------------------
-- Autopairs config
--------------------------------------------------------------------------------
-- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
