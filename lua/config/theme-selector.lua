local M = {}

-- File path where themes are stored
local theme_file = vim.fn.stdpath("config") .. "/.colortheme"

-- List of aviable themes  
local themes = {
  "yorumi",
  "catppuccin",
  "everforest",
  "gruvbox",
  "kanagawa",
  "nightfox",
  "nord",
  "onedark",
  "oxocarbon",
  "solarized",
  "tokyonight",
}

-- Function for apply a theme 
local function apply_theme(theme)
  -- Protect the colorscheme command if the change fails
  local ok, _ = pcall(vim.cmd.colorscheme, theme)
  if not ok then
    vim.notify("Error loading theme: " .. theme, vim.log.levels.ERROR)
  end
end

-- Read the current theme from the configuration file
local function get_current_theme()
  local f = io.open(theme_file, "r")
  if not f then return nil end
  local theme = f:read("*l")
  f:close()
  return theme
end

-- Save the selected theme 
local function save_theme(theme)
  local f = io.open(theme_file, "w")
  if not f then
    vim.notify("No se pudo guardar el tema", vim.log.levels.ERROR)
    return
  end
  f:write(theme)
  f:close()
end

-- Main function for selecting the theme
function M.select_theme()
  local original_theme = get_current_theme() or "default"
  apply_theme(original_theme)

  vim.ui.select(themes, {
    prompt = "Selecciona un tema de color:",
    format_item = function(item)
      return "  " .. item
    end,
  }, function(choice)
    if choice then
      apply_theme(choice)
      save_theme(choice)
      vim.notify("Tema aplicado: " .. choice, vim.log.levels.INFO)
    else
      -- Restore previous theme if canceled
      apply_theme(original_theme)
      vim.notify("Selección cancelada. Tema restaurado.", vim.log.levels.WARN)
    end
  end)
end

-- Automatically apply the saved theme at each startup
function M.apply_saved_theme()
  local theme = get_current_theme()
  if theme then
    apply_theme(theme)
  end
end

return M

