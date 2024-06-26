local utils = require("rvxlab.utils")

return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        utils.lazy_key("-", function()
            require("oil").open_float()
        end, "Open Oil"),
    },
    cmd = {
        "Oil",
    },
    opts = {
        view_options = {
            show_hidden = true,
        },
        columns = {
            "icon",
            "permissions",
            "size",
        },
    },
}
