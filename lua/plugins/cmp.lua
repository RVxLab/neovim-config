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
            preset = "enter",
        },
        sources = {
            completion = {
                enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
                list = {
                    selection = "manual",
                },
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon", "kind" },
                            { "label", "label_description", gap = 1 },
                        },
                    },
                },
            },
            providers = {
                -- dont show LuaLS require statements when lazydev has items
                lsp = { fallback_for = { "lazydev" } },
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            },
        },
    })
end)
