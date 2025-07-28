require("toggleterm").setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 15 -- Terminal height
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4 -- Terminal width
        end
    end,
    open_mapping = [[<C-\>]], -- Shortcut to open/close the terminal
    shading_factor = 2,
    direction = "horizontal",
    persist_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
})
function _G.toggle_term_based_on_focus()
    local neotree_open = vim.fn.bufname():match("NvimTree") -- Check if Neo-tree is open
    if neotree_open then
        vim.cmd("wincmd l") -- Move the focus on the coding buffer before open the terminal
    end
        vim.cmd("ToggleTerm direction=horizontal") -- Open the horizontal terminal     
end
