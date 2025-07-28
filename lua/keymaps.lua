------------------------------------------------------------------
-- 󱣱 Navigation in the editor                                   
------------------------------------------------------------------

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true, desc = "move left in insert mode" })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true, desc = "move down in insert mode" })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true, desc = "move up in insert mode"})
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true, desc = "move right in insert mode" })
vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = true, desc = "move the cursor to the end of the line" })
vim.keymap.set("i", "<C-b>", "<Home>", { noremap = true, silent = true, desc = "move the cursor to the beginning of the line" })
vim.keymap.set("i", "<C-d>", "<Esc>ddi", { noremap = true, silent = true, desc = "delete the entire line" })
vim.keymap.set("i", "<C-w>", "<C-o>daw", { noremap = true, silent = true, desc = "delete the word before the cursor" })

------------------------------------------------------------------
--  Neo-tree
------------------------------------------------------------------

vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Open/Close Neo-tree" })
vim.keymap.set("n", "<leader>nf", ":Neotree focus<CR>", { desc = "Focus on Neo-tree" })
vim.keymap.set("n", "<leader>gs", ":Neotree source=git_status toggle<CR>", { desc = "Open Git status on Neo-tree" })

------------------------------------------------------------------
--  Toggleterm
------------------------------------------------------------------

vim.keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Open/Close Terminal" })
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Close the terminal from terminal mode" })
vim.keymap.set("n", "<leader>th", ":lua toggle_term_based_on_focus()<CR>", { noremap = true, silent = true, desc = "open horizontal terminal depending on the focus" })
vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { noremap = true, silent = true, desc = "Open vertical terminal" })

------------------------------------------------------------------
--  Theme selector
------------------------------------------------------------------
vim.keymap.set("n", "<leader>tm", function()
  require("config.theme-selector").select_theme()
end, { desc = "Cambiar tema de colores" })

