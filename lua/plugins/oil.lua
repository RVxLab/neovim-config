local utils = require('utils')
local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("stevearc/oil.nvim")

    local oil = require("oil")

    oil.setup({
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
        },
        columns = {
            "icon",
            "mtime",
        },
        float = {
            preview_split = "right",
        },
    })

    utils.n_keymap("-", oil.open_float, "Open Filesystem")
end)
