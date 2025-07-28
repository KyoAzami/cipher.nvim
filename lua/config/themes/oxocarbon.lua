local M = {}

function M.setup(opts)
  vim.opt.background = 'dark'
  vim.g.oxocarbon_lua_transparent = opts.transparent
  vim.cmd.colorscheme('oxocarbon')
end

function M.preview()
  vim.cmd.colorscheme('oxocarbon')
end

return M
