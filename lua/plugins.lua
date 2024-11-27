local utils = require('utils')

-- Load mini.deps
require('mini.deps').setup({
    path = {
        package = path_package,
    },
})

-- Add the plugins
require('plugins.mini')
require('plugins.catppuccin')
require('plugins.treesitter')
require('plugins.telescope')

