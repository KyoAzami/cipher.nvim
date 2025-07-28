local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

-- Fixed text (always present at the top)
local fixed_ascii = {
  " ██████╗██╗██████╗ ██╗  ██╗███████╗██████╗        ██████╗ ",
  "██╔════╝██║██╔══██╗██║  ██║██╔════╝██╔══██╗      ██╔═████╗",
  "██║     ██║██████╔╝███████║█████╗  ██████╔╝█████╗██║██╔██║",
  "██║     ██║██╔═══╝ ██╔══██║██╔══╝  ██╔══██╗╚════╝████╔╝██║",
  "╚██████╗██║██║     ██║  ██║███████╗██║  ██║      ╚██████╔╝",
  " ╚═════╝╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝       ╚═════╝ ",
}

-- Function to obtain random ASCII art
local function get_random_ascii()
  local ascii_dir = vim.fn.stdpath("config") .. "/lua/config/ascii/"
  local files = vim.fn.globpath(ascii_dir, "*.txt", false, true)

  if #files == 0 then
    return { "⚠ No ASCII files found." }
  end

  math.randomseed(os.time()) -- Semilla única por sesión
  local random_file = files[math.random(#files)]
  local lines = {}

  local f = io.open(random_file, "r")
  if f then
    for line in f:lines() do
      table.insert(lines, line)
    end
    f:close()
  else
    return { "⚠ Failed to read ASCII file." }
  end

  return lines
end

-- Generate final header + ASCII art
local function generate_header()
  local combined = vim.deepcopy(fixed_ascii)
  vim.list_extend(combined, { "" }) -- espacio
  vim.list_extend(combined, get_random_ascii())
  return combined
end

-- Set virtual values 
dashboard.section.header.opts = {
  position = "center",
  hl = "AlphaHeader"
}

dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Footer
dashboard.section.footer.val = function()
  return "Welcome to Neovim — Powered by Kyo "
end

-- Botones
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "󰱼  Find file", ":Telescope find_files<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Configurar Alpha pero regenerando el header en cada ejecución
alpha.setup(dashboard.config)

-- Regenerate the header every time you enter nvim
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    dashboard.section.header.val = generate_header()
    pcall(vim.cmd.AlphaRedraw)
  end,
})

