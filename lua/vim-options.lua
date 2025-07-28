--      _          _                                  _   _             
-- __ _(_)_ __ ___| |___ __ _ __ _ __ _  _   ___ _ __| |_(_)___ _ _  ___
-- \ V / | '  \___| / -_) _` / _` / _| || | / _ \ '_ \  _| / _ \ ' \(_-<
--  \_/|_|_|_|_|  |_\___\__, \__,_\__|\_, | \___/ .__/\__|_\___/_||_/__/
--                      |___/         |__/      |_|                     

-- General options implemented by the editor (inherited from vim)
vim.cmd("set number")
vim.cmd("set mouse=a")
vim.cmd("syntax enable")
vim.cmd("set showcmd")
vim.cmd("set encoding=utf-8")
vim.cmd("set showmatch")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set autoindent")
vim.cmd("set smarttab")


-- Remove the ~ symbol from unnumbered lines
vim.opt.fillchars = { eob = " " }


-- Disable the creation of swap files
vim.opt.swapfile = false


