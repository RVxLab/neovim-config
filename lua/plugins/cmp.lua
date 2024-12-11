local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add({
        source = "saghen/blink.cmp",
        depends = {
            "rafamadriz/friendly-snippets",
            "folke/lazydev.nvim",
        },
        checkout = "v0.7.6", -- Version is needed for download
    })

    require("lazydev").setup({
        library = {
            -- Only load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    })

    require("blink.cmp").setup({
        keymap = {
            preset = "enter",
        },
        completion = {
            list = {
                selection = "manual",
            },
            menu = {
                draw = {
                    columns = {
                        { "kind_icon", "kind", gap = 1 },
                        { "label", "label_description", gap = 1 },
                    },
                },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "lazydev" },
            providers = {
                -- dont show LuaLS require statements when lazydev has items
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    fallbacks = { "lsp" },
                },
            },
        },
    })
end)
