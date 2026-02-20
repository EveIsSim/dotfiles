-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    --#region Themes

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        --config = function()
        --    vim.cmd('colorscheme rose-pine')
        --end
    })
    use({
        'catppuccin/nvim',
        as = 'catppuccin',
        -- config = function()
        --     vim.cmd('colorscheme catppuccin-mocha')
        -- end
    })

    use "EdenEast/nightfox.nvim"

    use({
        "vague-theme/vague.nvim",
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd.colorscheme("vague")
        end
    })

    --#endregion Themes

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')

    -- Automatically highlighting other uses
    use('RRethy/vim-illuminate')

    --#region LSP
    use({ 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' })

    --- Autocomplite UI core
    use({ 'hrsh7th/nvim-cmp' })     -- engine autocomplite
    use({ 'hrsh7th/cmp-nvim-lsp' }) -- hints from LSP

    --- Snippets
    use('L3MON4D3/LuaSnip')             -- Snippets
    use({ 'saadparwaiz1/cmp_luasnip' }) -- source luaSnip snippets (display [SNIP])

    -- Pretty kind icons/labels (Method/Struct/Interface)
    use({ 'onsails/lspkind.nvim' })

    use({ 'hrsh7th/cmp-buffer' }) -- hits from buffer
    use({ 'hrsh7th/cmp-path' })   -- hint path files


    -- Mason + lsp
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    })

    use('Hoffs/omnisharp-extended-lsp.nvim')

    -- LSP progres bar
    use({ "j-hui/fidget.nvim" })

    --#end LSP

    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }

    use("vim-test/vim-test") -- run tests
    use('nvim-neotest/nvim-nio')

    -- debug
    use {
        "mfussenegger/nvim-dap",             -- main plugind for debug
        "rcarriga/nvim-dap-ui",              -- UI for nvim-dap
        "nvim-telescope/telescope-dap.nvim", -- integration nvim-dap with Telescope
        "theHamsta/nvim-dap-virtual-text",   -- virtual

        -- GO
        "leoluz/nvim-dap-go", -- Go-adapter for nvim-dap
    }

    -- colorizer
    use("norcalli/nvim-colorizer.lua") -- run tests

    -- #region GIT
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
        end
    }

    use('tpope/vim-fugitive')
    use('airblade/vim-gitgutter')
    -- #endregion GIT

    --#region Markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })
    --#endregion
end)
