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
require("plugins.conform")
require("plugins.gitsigns")
require("plugins.autopairs")
require("plugins.dressing")
require("plugins.eunuch")
require("plugins.heritage")
require("plugins.indent-blankline")
require("plugins.neoscroll")
require("plugins.php")
require("plugins.projectionist")
require("plugins.refactoring")
require("plugins.rooter")
require("plugins.screenshot")
require("plugins.surround")
require("plugins.todo-comments")
require("plugins.ts-comments")
require("plugins.blade-nav")
require("plugins.testing")
