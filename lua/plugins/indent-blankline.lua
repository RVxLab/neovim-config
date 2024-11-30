local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("lukas-reineke/indent-blankline.nvim")

    require("ibl").setup()
end)
