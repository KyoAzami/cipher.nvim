local M = {}

function M.setup(opts)
  vim.g.solarized_visibility = 'high'
  vim.g.solarized_diffmode = 'high'
  vim.g.solarized_transparent = opts.transparent and 1 or 0
  vim.cmd.colorscheme('solarized')
end

function M.preview()
  vim.cmd.colorscheme('solarized')
end

return M
