local utils = require("rvxlab.utils")

return {
    "adalessa/laravel.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvimtools/none-ls.nvim",
        "j-hui/fidget.nvim",
    },
    cmd = { "Artisan", "Laravel" },
    keys = {
        utils.lazy_key("<leader>la", ":Laravel artisan<cr>", "Open [A]rtisan"),
        utils.lazy_key("<leader>lr", ":Laravel routes<cr>", "Show Laravel [r]outes"),
    },
    event = { "VeryLazy" },
    config = true,
    init = function()
        require("telescope").load_extension("laravel")
    end,
}
