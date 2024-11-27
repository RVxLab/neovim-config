local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add({
        source = "saghen/blink.cmp",
        depends = {
            "rafamadriz/friendly-snippets",
        },
        checkout = "v0.6.2",
    })

    require("blink.cmp").setup({})
end)
