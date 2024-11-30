local utils = require("utils")
local add, later = MiniDeps.add, MiniDeps.later

local format_on_save_options = {
    timeout_ms = 500,
    lsp_format = "fallback",
}

local prettier_opts = {
    "biome",
    "prettierd",
    "prettier",
    stop_after_first = true,
}

later(function()
    add("stevearc/conform.nvim")

    require("conform").setup({
        formatters_by_ft = {
            php = { "pint", "php-cs-fixer" },
            javascript = prettier_opts,
            typescript = prettier_opts,
            typescriptreact = prettier_opts,
            blade = prettier_opts,
            lua = { "stylua" },
            sh = { "shellcheck" },
        },
        format_on_save = format_on_save_options,
    })

    utils.n_keymap("<leader>cf", function()
        local options = vim.tbl_deep_extend("force", format_on_save_options, {
            async = true,
            callback = function(err)
                if err ~= nil then
                    vim.notify(err, vim.log.levels.ERROR, {
                        title = "Conform",
                    })
                end
            end,
        })

        require("conform").format(options)
    end, "[F]ormat the current buffer")
end)
