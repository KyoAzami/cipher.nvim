local M = {}

function M.setup(opts)
  vim.g.everforest_background = 'hard'
  vim.g.everforest_transparent_background = opts.transparent and 1 or 0
  vim.g.everforest_better_performance = 1
  vim.cmd.colorscheme('everforest')
end

function M.preview()
  vim.cmd.colorscheme('everforest')
end

return M
