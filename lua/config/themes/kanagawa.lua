local M = {}

function M.setup(opts)
  require('kanagawa').setup({
    transparent = opts.transparent,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none"
          }
        }
      }
    }
  })
  vim.cmd.colorscheme('kanagawa')
end

function M.preview()
  vim.cmd.colorscheme('kanagawa')
end

return M
