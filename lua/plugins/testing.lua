local utils = require("utils")
local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add({
        source = "nvim-neotest/neotest",
        depends = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",

            -- Adapters
            "V13Axel/neotest-pest", -- PestPHP
            "nvim-neotest/neotest-jest", -- Jest
        },
    })

    local neotest = require("neotest")
    neotest.setup({
        adapters = {
            require("neotest-pest")({
                parallel = function()
                    local threads_available = vim.uv.available_parallelism()
                    local ideal_parallel_tests = math.floor(threads_available / 2)

                    return math.min(0, ideal_parallel_tests)
                end,
            }),
            require("neotest-jest")({
                env = {
                    CI = true,
                },
                -- For some reason, turning it off means turning it on???
                jest_test_discovery = false,
            }),
        },
        discovery = {
            enabled = false,
        },
    })

    utils.n_keymap("<leader>tt", neotest.run.run, "Run the current [t]est")
    utils.n_keymap("<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
    end, "Run the current [f]ile")
    utils.n_keymap("<leader>tl", neotest.run.run_last, "Run the [l]ast run test")
    utils.n_keymap(
        "<leader>td",
        utils.bind(neotest.run.run, {
            strategy = "dap",
        }),
        "Run test with [d]ebugger"
    )

    utils.n_keymap("<leader>tuo", neotest.output_panel.toggle, "Toggle [o]utput panel")
    utils.n_keymap("<leader>tus", neotest.summary.toggle, "Toggle [s]ummary panel")

    require("which-key").add({
        mode = "n",
        { "<leader>t", group = "Testing" },
        { "<leader>tu", group = "Testing UI" },
    })
end)
