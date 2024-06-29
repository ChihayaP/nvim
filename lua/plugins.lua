local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tanvirtin/monokai.nvim",
    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer", -- buffer auto-completion
            "hrsh7th/cmp-path", -- path auto-completion
            "hrsh7th/cmp-cmdline", -- cmdline auto-completion
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        config = function()
            require("config.nvim-tree")
        end,
    },
    -- Better terminal integration
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("config.toggleterm")
        end,
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.telescope")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.lualine")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("config.nvim-autopairs")
        end,
    },
    -- Show indentation and blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("config.indent-blankline")
        end,
    },
    -- Make surrounding easier
    -- ------------------------------------------------------------------
    -- Old text                    Command         New text
    -- ------------------------------------------------------------------
    -- surr*ound_words             gziw)           (surround_words)
    -- *make strings               gz$"            "make strings"
    -- [delete ar*ound me!]        gzd]            delete around me!
    -- remove <b>HTML t*ags</b>    gzdt            remove HTML tags
    -- 'change quot*es'            gzc'"           "change quotes"
    -- delete(functi*on calls)     gzcf            function calls
    -- ------------------------------------------------------------------
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        -- You can use the VeryLazy event for things that can
        -- load later and are not important for the initial UI
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- To solve the conflicts with leap.nvim
                -- See: https://github.com/ggandor/leap.nvim/discussions/59
                keymaps = {
                    insert = "<C-g>z",
                    insert_line = "gC-ggZ",
                    normal = "gz",
                    normal_cur = "gZ",
                    normal_line = "gzgz",
                    normal_cur_line = "gZgZ",
                    visual = "gz",
                    visual_line = "gZ",
                    delete = "gzd",
                    change = "gzc",
                },
            })
        end,
    },
    -- Treesitter-integration
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("config.nvim-treesitter")
        end,
    },
    -- Nvim-treesitter text objects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("config.nvim-treesitter-textobjects")
        end,
    },
    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                separator_style = {" ", " "},
            },
            highlights = {
                buffer_selected = { italic = false, bold = false },
            },
        },
        config = function()
            require("config.bufferline")
        end,
    },
    {
        'jdhao/better-escape.vim',
        event = 'InsertEnter',
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },
    -- Tabout
    {
        'abecodes/tabout.nvim',
        lazy = false,
        config = function()
            require("config.tabout")
        end,
        dependencies = { -- These are optional
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
            "hrsh7th/nvim-cmp"
        },
        opt = true,  -- Set this to true if the plugin is optional
        event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
        priority = 1000,
    },
})

