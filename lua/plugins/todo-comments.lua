local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add("folke/todo-comments.nvim")

    require("todo-comments").setup()
end)
