local M = {}

function M.setup(opts)
  require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = opts.transparent,
    integrations = {
      cmp = true,
      telescope = true,
      mason = true,
      which_key = true,
    }
  })
  vim.cmd.colorscheme('catppuccin')
end

function M.preview()
  vim.cmd.colorscheme('catppuccin')
end

return M
