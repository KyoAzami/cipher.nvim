--       _           _           _         _        _ _      _   _          
--  _ __| |_  _ __ _(_)_ _  ___ (_)_ _  __| |_ __ _| | |__ _| |_(_)___ _ _  
-- | '_ \ | || / _` | | ' \(_-< | | ' \(_-<  _/ _` | | / _` |  _| / _ \ ' \ 
-- | .__/_|\_,_\__, |_|_||_/__/ |_|_||_/__/\__\__,_|_|_\__,_|\__|_\___/_||_|
-- |_|         |___/                                                        

return {
  -------------------------------------------------------------------------------
  --  Color Schemes
  -------------------------------------------------------------------------------
  { "yorumicolors/yorumi.nvim" }, -- Deep sea dark
  { "catppuccin/nvim", name = "catppuccin" }, -- Softer color palette
  { "sainnhe/everforest" }, -- Green-based earthy colors
  { "ellisonleao/gruvbox.nvim" }, -- Classic warm colors
  { "rebelot/kanagawa.nvim" }, -- Japanese painting inspired
  { "EdenEast/nightfox.nvim" }, -- Fox-themed palette variants
  { "shaunsingh/nord.nvim" }, -- Arctic, north-bluish
  { "navarasu/onedark.nvim" }, -- Default Atom/VSCode dark theme
  { "nyoom-engineering/oxocarbon.nvim" }, -- IBM Carbon inspired
  { "shaunsingh/solarized.nvim" }, -- Perfect color contrast
  { "folke/tokyonight.nvim" }, -- Tokyo night colors

  -------------------------------------------------------------------------------
  --  Core Essentials
  -------------------------------------------------------------------------------
  { "goolord/alpha-nvim", event = "VimEnter" }, -- Startup dashboard
  { "nvim-lualine/lualine.nvim", event = "VeryLazy" }, -- Status line
  { "nvim-lua/plenary.nvim" }, -- upgrade the UI
  { "nvim-tree/nvim-web-devicons", lazy = true }, -- File icons
  { "stevearc/dressing.nvim", event = "VeryLazy" }, -- Better UI for commands
  { "folke/which-key.nvim", event = "VeryLazy" }, -- Keybindings helper

  -------------------------------------------------------------------------------
  --  UI Enhancements
  -------------------------------------------------------------------------------
  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x" }, -- File explorer
  { "MunifTanjim/nui.nvim" }, -- A dependence for Neo-tree
  { "akinsho/bufferline.nvim", event = "VeryLazy" }, -- Tabline
  { "lewis6991/gitsigns.nvim", event = "BufReadPre" }, -- Git gutter signs
  { "lukas-reineke/indent-blankline.nvim", event = "BufReadPre" }, -- Indent guides
  { "RRethy/vim-illuminate", event = "BufReadPost" }, -- Highlight word under cursor

  -------------------------------------------------------------------------------
  --  Search & Navigation
  -------------------------------------------------------------------------------
  { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = "nvim-lua/plenary.nvim" }, -- Fuzzy finder
  { "sindrets/diffview.nvim", event = "VeryLazy" }, -- Git diff viewer
  { "ThePrimeagen/harpoon", event = "VeryLazy" }, -- File bookmarking
  { "ggandor/leap.nvim", event = "VeryLazy" }, -- Quick jumping

  -------------------------------------------------------------------------------
  -- 󰌢 Development - LSP & Completion
  -------------------------------------------------------------------------------
  { "neovim/nvim-lspconfig" }, -- LSP configurations
  { "williamboman/mason.nvim" }, -- LSP/DAP/linter manager
  { "williamboman/mason-lspconfig.nvim" }, -- Mason-LSP bridge
  { "hrsh7th/nvim-cmp", event = "InsertEnter" }, -- Completion engine
  { "hrsh7th/cmp-nvim-lsp" }, -- LSP completion source
  { "hrsh7th/cmp-buffer" }, -- Buffer words source
  { "hrsh7th/cmp-path" }, -- Path completion source
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-cmdline" }, -- Command line completion
  { "L3MON4D3/LuaSnip", event = "InsertEnter" }, -- Snippet engine
  { "rafamadriz/friendly-snippets" }, -- Prebuilt snippets
  { "b0o/schemastore.nvim" }, -- JSON schemas

  -------------------------------------------------------------------------------
  --  Code Tools
  -------------------------------------------------------------------------------
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Better syntax
  { "windwp/nvim-autopairs", event = "InsertEnter" }, -- Auto-pairing
  { "numToStr/Comment.nvim", event = "BufReadPre" }, -- Easy commenting
  { "kylechui/nvim-surround", event = "VeryLazy" }, -- Surround text objects
  { "AndrewRadev/tagalong.vim", event = "VeryLazy" }, -- HTML tag rename
  { "tpope/vim-repeat", event = "VeryLazy" }, -- Better command repetition

  -------------------------------------------------------------------------------
  -- 󰊢 Version Control
  -------------------------------------------------------------------------------
  { "TimUntersberger/neogit", cmd = "Neogit" }, -- Git interface
  { "akinsho/git-conflict.nvim", config = true }, -- Conflict resolution
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },

  -------------------------------------------------------------------------------
  --  Terminal & Debugging
  -------------------------------------------------------------------------------
  { "akinsho/toggleterm.nvim", event = "VeryLazy" }, -- Built-in terminal
  { "mfussenegger/nvim-dap" }, -- Debug Adapter Protocol
  { "rcarriga/nvim-dap-ui" }, -- Debugging UI
  { "theHamsta/nvim-dap-virtual-text" }, -- Debug virtual text

  -------------------------------------------------------------------------------
  -- 󰹕 Notes & Documentation
  -------------------------------------------------------------------------------
  { "vimwiki/vimwiki", event = "VeryLazy" }, -- Personal wiki
  { "folke/zen-mode.nvim", cmd = "ZenMode" }, -- Distraction-free mode

  -------------------------------------------------------------------------------
  --  Productivity
  -------------------------------------------------------------------------------
  { "folke/persistence.nvim", event = "BufReadPre" }, -- Session management
  { "folke/todo-comments.nvim", event = "BufRead" }, -- TODO highlights
  { "folke/trouble.nvim", cmd = "Trouble" }, -- Diagnostics list
  { "andymass/vim-matchup", event = "BufReadPost" }, -- Better % matching

  -------------------------------------------------------------------------------
  --  Personal plugins
  -------------------------------------------------------------------------------
}
