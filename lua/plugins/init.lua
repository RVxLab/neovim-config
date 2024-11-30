local path_package = require("config").path_package

-- Load mini.deps
require("mini.deps").setup({
    path = {
        package = path_package,
    },
})

-- Add the plugins
require("plugins.snacks")
require("plugins.which-key")
require("plugins.mini")
require("plugins.catppuccin")
require("plugins.lazydev")
require("plugins.diagnostics")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.oil")
