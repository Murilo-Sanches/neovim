local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- API NeoVim   
    'folke/neodev.nvim',

    -- Keyboard
    'folke/which-key.nvim',

    -- Theme
    {
      'loctvl842/monokai-pro.nvim',
      lazy = false
    },

    'andweeb/presence.nvim',

    -- File tree
    'nvim-tree/nvim-tree.lua',

    -- Bottom bar
    'nvim-lualine/lualine.nvim',

    -- Highlights
    'nvim-treesitter/nvim-treesitter',

    -- Finder
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.5',
      dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    -- LSP
    {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },

    -- Completion engine
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets'
})
