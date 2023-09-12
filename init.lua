-- global init --
o = vim.o
bo = vim.bo
wo = vim.wo

require("vimconfig")
require("plugins")
require("maps")
require("tree")
require("completion")
require("snippet")

require("lualine").setup({
	options = {
		theme = "ayu_mirage",
	},
})

vim.g.camelcasemotion_key = "<leader>"
vim.opt.termguicolors = true
require("gitsigns").setup({})
require("nvim-surround").setup({})
require("nvim-autopairs").setup({})
require("todo-comments").setup()

-- Git
vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = "" -- custom config file path

-- LSP
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
local nvim_lsp = require("lspconfig")
-- LSPSaga
local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.setup({
	ui = {
		winblend = 10,
		border = "rounded",
		colors = {
			normal_bg = "#002b36",
		},
	},
	symbol_in_winbar = {
		enable = false,
	},
})

-- Theme Configuration
o.background = "dark"
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme dracula")

-- Bufferline --
require("bufferline").setup({
	options = {
		separator_style = "slant",
		diagnostics = "nvim_lsp",
		buffer_close_icon = "×",

		hover = {
			enabled = true,
			delay = 150,
			reveal = { "close" },
		},
	},
})

-- TreeSettter Config
local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = { "lua", "rust", "c", "go", "json", "html", "yaml" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

-- Indent lines
require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
})

-- Better Escape
require("better_escape").setup({
	mapping = { "jk", "jj" }, -- a table with mappings to use
	timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
	clear_empty_lines = false, -- clear line after escaping if there is only whitespace
	keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
})

-- Telescope
actions = require("telescope.actions")
require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	defaults = {
		layout_strategy = "vertical",
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-e>"] = actions.close,
			},
		},
	},
})

local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- Annotation toolkit
require("neogen").setup({
	enabled = true, --if you want to disable Neogen
	input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
	-- jump_map = "<C-e>"       -- (DROPPED SUPPORT, see [here](#cycle-between-annotations) !) The keymap in order to jump in the annotation fields (in insert mode)
})

-- Null-ls (Code formatter)
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.beautysh,
		null_ls.builtins.formatting.djlint,
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
		}),
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.jsonlint,
		null_ls.builtins.diagnostics.shellcheck,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })

-- Typescript
local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local protocol = require("vim.lsp.protocol")

local on_attach = function(client, bufnr)
	-- format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

-- TypeScript
nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	single_file_support = true,
	cmd = { "typescript-language-server", "--stdio" },
})
