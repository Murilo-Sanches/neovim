local languages = {
    -- Web
    'html',
    'css',
    'javascript',
    'typescript',
    'php',
    'c_sharp',
    'java',

    -- General
    'lua',
    'vim',
    'json',

    -- Low Level
    'c',
    'cpp'
}

require('nvim-treesitter.configs').setup {
    ensure_installed = languages,

    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
}
