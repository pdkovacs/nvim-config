-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "gh", " <Nop>", { desc = "Calling hiearchy" })
vim.keymap.set("n", "ghi", vim.lsp.buf.incoming_calls, { desc = "Incoming calls" })
