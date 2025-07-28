--  _      _ _   _      _                __ _                    _   _          
-- (_)_ _ (_) |_(_)__ _| |  __ ___ _ _  / _(_)__ _ _  _ _ _ __ _| |_(_)___ _ _  
-- | | ' \| |  _| / _` | | / _/ _ \ ' \|  _| / _` | || | '_/ _` |  _| / _ \ ' \ 
-- |_|_||_|_|\__|_\__,_|_| \__\___/_||_|_| |_\__, |\_,_|_| \__,_|\__|_\___/_||_|
--                                           |___/                              

--mapleadear assignment
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" 

--call vim legacy options file
require("vim-options")

--call the lazy configuration file (plugin manager)
require("config.lazy")


--calls the key mapping file
require("keymaps")

--call to the theme selector file
require("config.theme-selector").apply_saved_theme()

vim.o.cursorline = true  --activates cursor line highlighting
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.o.cursorline = true  --makes sure that it also works in insert mode
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.o.cursorline = true  --returns to normal mode
  end,
})


