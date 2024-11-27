local utils = require("utils")
local now, later = MiniDeps.now, MiniDeps.later

now(function()
    require("mini.icons").setup()
    require("mini.statusline").setup()

    local starter = require("mini.starter")

    starter.setup({
        header = require("art.header"),
        silent = true,
        footer = require("starter").make_footer({
            time = 123,
            memory = 456,
            plugins = 789,
        }),
    })
end)

later(function()
    require("mini.splitjoin").setup()
    require("mini.files").setup()

    utils.n_keymap("-", MiniFiles.open, "Browse files")
end)
