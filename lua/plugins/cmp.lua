local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add({
        source = "saghen/blink.cmp",
        depends = {
            "rafamadriz/friendly-snippets",
        },
        checkout = "v0.7.1",
    })

    require("blink.cmp").setup({
        keymap = "enter",
        completion = {
            enabled_providers = {
                "lsp",
                "path",
                "snippets",
                "buffer",
                "lazydev",
            },
            ghost_text = {
                enabled = true,
            },
        },
    })
end)
