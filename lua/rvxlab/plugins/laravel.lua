local utils = require("rvxlab.utils")

return {
    "adalessa/laravel.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvimtools/none-ls.nvim",
        "j-hui/fidget.nvim",
        "kevinhwang91/promise-async",
    },
    cmd = { "Laravel" },
    keys = {
        utils.lazy_key("<leader>pla", ":Laravel artisan<cr>", "Open [A]rtisan"),
        utils.lazy_key("<leader>plr", ":Laravel routes<cr>", "Show Laravel [r]outes"),
    },
    event = { "VeryLazy" },
    opts = {
        lsp_server = "phpactor",
        environments = {
            auto_dicover = false, -- Yes, this is correct
        },
    },
    config = true,
}
