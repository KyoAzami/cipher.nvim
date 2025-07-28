local M = {}

function M.setup(opts)
  require('onedark').setup({
    style = 'darker',
    transparent = opts.transparent
  })
  vim.cmd.colorscheme('onedark')
end

function M.preview()
  vim.cmd.colorscheme('onedark')
end

return M
