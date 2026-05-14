local M = {}

function M.setup(opts)
  require('yorumi').setup({
    transparent_background = true
  })
  vim.cmd.colorscheme('yorumi')
end

function M.preview()
  vim.cmd.colorscheme('yorumi')
end

return M
