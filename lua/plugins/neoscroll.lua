local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("karb94/neoscroll.nvim")

    require("neoscroll").setup()
end)
