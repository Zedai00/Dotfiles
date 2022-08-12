vim.cmd([[packadd packer.nvim]])
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
return require("packer").startup(function(use)
    use 'puremourning/vimspector'
    use 'lukas-reineke/lsp-format.nvim'
    use 'andweeb/presence.nvim'
    -- Lua
    use 'Pocco81/AutoSave.nvim'
    use {
        'folke/which-key.nvim',
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use 'lambdalisue/suda.vim'
    use 'navarasu/onedark.nvim'
    use { 'sudormrfbin/cheatsheet.nvim',
        requires = {
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        }
    }
    use 'neovimhaskell/haskell-vim'
    use 'jiangmiao/auto-pairs'
    use { 'neoclide/coc.nvim', branch = 'release' }
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'dag/vim-fish'
    use({ 'ckipp01/stylua-nvim', run = 'cargo install stylua' })
    use 'wbthomason/packer.nvim'
    use 'andersevenrud/nordic.nvim'
    use({ 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } })
    require('nvim-tree').setup()
end)
