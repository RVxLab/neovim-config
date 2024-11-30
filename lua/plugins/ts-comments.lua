local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("folke/ts-comments.nvim")

    require("ts-comments").setup({
        lang = {
            blade = "{{-- %s --}}",
        },
    })
end)
