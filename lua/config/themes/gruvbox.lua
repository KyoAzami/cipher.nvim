local M = {}

function M.setup(opts)
  require('gruvbox').setup({
    transparent_mode = opts.transparent
  })
  vim.cmd.colorscheme('gruvbox')
end

function M.preview()
  vim.cmd.colorscheme('gruvbox')
end

return M
