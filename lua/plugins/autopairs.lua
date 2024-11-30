local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("windwp/nvim-autopairs")

    require("nvim-autopairs").setup()
end)
