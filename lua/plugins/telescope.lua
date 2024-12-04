local utils = require("utils")

local add, later = MiniDeps.add, MiniDeps.later

local function build_fzf_native(dep)
    vim.cmd(string.format("cd %s", dep.path))
    vim.fn.system("make")
    vim.cmd("cd -")
end

later(function()
    add({
        source = "nvim-telescope/telescope-fzf-native.nvim",
        hooks = {
            post_checkout = build_fzf_native,
            post_install = build_fzf_native,
        },
    })

    add({
        source = "nvim-telescope/telescope-live-grep-args.nvim",
        checkout = "v1.1.0",
    })

    add({
        source = "nvim-telescope/telescope.nvim",
        checkout = "0.1.x",
        depends = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    })

    local actions = require("telescope.actions")
    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<Esc>"] = actions.close, -- Remove the need to press escape twice to exit
                    ["<C-t>"] = actions.cycle_history_next,
                    ["<C-r>"] = actions.cycle_history_prev,
                },
            },
            file_ignore_patterns = {
                ".git/",
            },
        },
        pickers = {
            find_files = {
                hidden = false,
            },
        },
        extensions = {
            live_grep_args = {
                auto_quoting = true,
                mappings = {
                    i = {
                        ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                    },
                },
            },
        },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")

    local builtin = require("telescope.builtin")
    utils.n_keymap("<leader>ff", builtin.find_files, "Find: [F]iles")
    utils.n_keymap(
        "<leader>fF",
        utils.bind(builtin.find_files, {
            prompt_title = "All files",
            no_ignore = true,
        }),
        "Find: All [F]iles"
    )
    utils.n_keymap("<leader>fs", telescope.extensions.live_grep_args.live_grep_args, "Find: [S]earch")
    utils.n_keymap("<leader>fb", builtin.buffers, "Find: [B]uffers")

    require("which-key").add({
        mode = "n",
        { "<leader>f", group = "[F]ind" },
    })
end)
