-- Buffer navigation
vim.keymap.set("n", "<C-n>", ":bnext<CR>")
vim.keymap.set("n", "<C-p>", ":bprevious<CR>")

-- Unmap default LSP diagnostics mappings that conflict with buffer delete
vim.keymap.del("n", "<C-W>d")
vim.keymap.del("n", "<C-W><C-D>")
vim.keymap.set("n", "<C-w>", ":bd<CR>")

-- Window navigation
vim.keymap.set("n", "<C-J>", "<C-W>j")
vim.keymap.set("n", "<C-K>", "<C-W>k")
vim.keymap.set("n", "<C-H>", "<C-W>h")
vim.keymap.set("n", "<C-L>", "<C-W>l")

-- General editing
vim.keymap.set("n", "<esc><esc>", ":noh<CR><esc>")  -- Remove highlight
vim.keymap.set("n", "Y", "y$")  -- Make Y behave like other capitals
vim.keymap.set("v", "<", "<gv")  -- Reselect visual block after indent
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<Leader>ss", ":setlocal spell! spell?<CR>")  -- Spell checking toggle
