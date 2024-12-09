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
require("plugins.diagnostics")
require("plugins.treesitter")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.oil")
require("plugins.conform")
require("plugins.git")
require("plugins.php")
require("plugins.projectionist")
require("plugins.refactoring")
require("plugins.screenshot")
require("plugins.blade-nav")
require("plugins.testing")
require("plugins.misc")
require("plugins.debugging")
