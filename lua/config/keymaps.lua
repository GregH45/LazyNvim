-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle file explorer with backslash
vim.keymap.set("n", "\\", function()
  Snacks.explorer()
end, { desc = "Toggle Explorer" })
