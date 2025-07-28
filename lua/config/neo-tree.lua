

require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            hide_dotfiles = true,  -- adjust this according to your preference
        },
        use_libuv_file_watcher = true, -- automatically refreshes changes
    },
    window = {
        width = 30,  -- adjusts the Neo-tree window size
        show_line_numbers = false,
    },
      
    git_status = {
        symbols = {
            added     = "", -- Added files/Archivos añadidos
            modified  = "󰌇", -- Changed files/Archivos modificados
            deleted   = "󰛌", -- Deleted files/Archivos eliminados
            renamed   = "", -- Renamed files/Archivos renombrados
            untracked = "", -- New files not tracked/Archivos nuevos sin seguimiento
            ignored   = "◌", -- Ignored files/Archivos ignorados
            unstaged  = "✗", -- Changes without staging/Cambios sin "staging"
            staged    = "✓", -- Changes prepared for commit/Cambios preparados para commit
            conflict  = "", -- Conflicts in git/Conflictos de Git
        },
    },

    default_component_configs = {
        git_status = {
            symbols = {
                added     = "",
                modified  = "󰌇",
                deleted   = "󰛌",
                renamed   = "",
                untracked = "",
            },
        },
    },


})

