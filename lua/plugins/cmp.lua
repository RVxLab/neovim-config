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
        keymap = {
            preset = "super-tab",
        },
        sources = {
            completion = {
                enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
                list = {
                    selection = "manual",
                },
            },
            providers = {
                -- dont show LuaLS require statements when lazydev has items
                lsp = { fallback_for = { "lazydev" } },
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            },
            ghost_text = {
                enabled = true,
            },
        },
    })
end)
