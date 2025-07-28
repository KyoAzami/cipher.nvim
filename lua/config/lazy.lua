--       _               _                                          
--  _ __| |_  _ __ _ ___(_)_ _    _ __  __ _ _ _  __ _ __ _ ___ _ _ 
-- | '_ \ | || / _` |___| | ' \  | '  \/ _` | ' \/ _` / _` / -_) '_|
-- | .__/_|\_,_\__, |   |_|_||_| |_|_|_\__,_|_||_\__,_\__, \___|_|  
-- |_|         |___/                                  |___/         

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)


-- here we call the file where we installed the plugins to be activated from the lazy call in init.lua
require("lazy").setup("plugins")

-- Automatically load all files in lua/config/
local config_path = vim.fn.stdpath("config") .. "/lua/config"
for _, file in ipairs(vim.fn.readdir(config_path)) do
  if file:match("%.lua$") then
    local modname = "config." .. file:gsub("%.lua$", "")
        pcall(require, modname)
  end
end

