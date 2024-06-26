local utils = require("rvxlab.utils")

return {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    opts = {
        line_numbers = false,
        max_lines = 5,
        multiline_threshold = 3,
    },
    init = function()
        utils.n_keymap("[c", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, "Go to parent [c]ontext")
    end,
}
