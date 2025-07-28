local M = {}

-- Ruta donde se guarda el tema seleccionado
local theme_file = vim.fn.stdpath("config") .. "/.colortheme"

-- Lista de temas disponibles (debe coincidir con los nombres del setup de cada tema)
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

-- Función para aplicar un tema
local function apply_theme(theme)
  -- Protege el comando colorscheme por si el tema falla
  local ok, _ = pcall(vim.cmd.colorscheme, theme)
  if not ok then
    vim.notify("Error loading theme: " .. theme, vim.log.levels.ERROR)
  end
end

-- Leer el tema actual desde el archivo de configuración
local function get_current_theme()
  local f = io.open(theme_file, "r")
  if not f then return nil end
  local theme = f:read("*l")
  f:close()
  return theme
end

-- Guardar el tema seleccionado
local function save_theme(theme)
  local f = io.open(theme_file, "w")
  if not f then
    vim.notify("No se pudo guardar el tema", vim.log.levels.ERROR)
    return
  end
  f:write(theme)
  f:close()
end

-- Función principal para seleccionar el tema
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
      -- Restaurar tema anterior si se cancela
      apply_theme(original_theme)
      vim.notify("Selección cancelada. Tema restaurado.", vim.log.levels.WARN)
    end
  end)
end

-- Aplicar automáticamente el tema guardado en cada inicio
function M.apply_saved_theme()
  local theme = get_current_theme()
  if theme then
    apply_theme(theme)
  end
end

return M

