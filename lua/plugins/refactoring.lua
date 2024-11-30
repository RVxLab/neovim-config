local utils = require("utils")
local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add({
        source = "ThePrimeagen/refactoring.nvim",
        depends = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    })

    local refactoring = require("refactoring")
    refactoring.setup()

    utils.x_keymap("<leader>ref", utils.bind(refactoring.refactor, "Extract Function"), "Extract [F]unction")
    utils.n_keymap("<leader>rif", utils.bind(refactoring.refactor, "Inline Function"), "Inline [F]unction")
    utils.x_keymap("<leader>rev", utils.bind(refactoring.refactor, "Extract Variable"), "Extract [V]ariable")
    utils.keymap({ "n", "x" }, "<leader>riv", utils.bind(refactoring.refactor, "Inline Variable"), "Inline [V]ariable")

    require("which-key").add({
        mode = { "n", "x" },
        { "<leader>r", group = "Refactor" },
        { "<leader>re", group = "Refactor: Extract" },
        { "<leader>ri", group = "Refactor: Inline" },
    })
end)
