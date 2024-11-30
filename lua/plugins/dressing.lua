local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("stevearc/dressing.nvim")

    require("dressing").setup()
end)
