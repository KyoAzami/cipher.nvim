local M = {}

function M.setup(opts)
  vim.g.nord_contrast = true
  vim.g.nord_borders = false
  vim.g.nord_disable_background = opts.transparent
  vim.cmd.colorscheme('nord')
end

function M.preview()
  vim.cmd.colorscheme('nord')
end

return M
