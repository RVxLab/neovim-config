local utils = require("utils")
local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add({
        source = "adalessa/laravel.nvim",
        depends = {
            "tpope/vim-dotenv",
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            "kevinhwang91/promise-async",
        },
    })

    require("laravel").setup({
        lsp_server = "intelephense",
        environments = {
            auto_dicover = false, -- This is the option name, not a typo
        },
    })

    require("which-key").add({
        { "<leader>pl", group = "Laravel" },
    })

    utils.n_keymap("<leader>pla", utils.bind(vim.cmd, "Laravel artisan"), "[A]rtisan")
end)
