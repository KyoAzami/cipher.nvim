local M = {}

function M.setup(opts)
  require('tokyonight').setup({
    style = 'night',
    transparent = opts.transparent,
    sidebars = {
      'qf',
      'vista_kind',
      'terminal',
      'packer'
    }
  })
  vim.cmd.colorscheme('tokyonight')
end

function M.preview()
  vim.cmd.colorscheme('tokyonight')
end

return M
