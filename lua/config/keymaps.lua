-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = "\\"

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Diagnostics
keymap.set("n", "<C-k><C-l>", function()
  vim.diagnostic.goto_next()
end, opts)

-- disable relative lines
keymap.set("n", "<C-L><C-L>", ":set invrelativenumber<CR>")

-- Escape insert mode
keymap.set("i", "jj", "<ESC>")

keymap.set("i", "<Tab>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })
