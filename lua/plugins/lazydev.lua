local add, later = MiniDeps.add, MiniDeps.later

later(function ()
    add("folke/lazydev.nvim")

    require("lazydev").setup({
        library = {
            -- Only load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    })
end)
