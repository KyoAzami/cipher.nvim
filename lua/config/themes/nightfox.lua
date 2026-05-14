local M = {}

function M.setup(opts)
  require('nightfox').setup({
    options = {
      transparent = true
    }
  })
  vim.cmd.colorscheme('nightfox')
end

function M.preview()
  vim.cmd.colorscheme('nightfox')
end

return M
