local utils = require("utils")
local add, later = MiniDeps.add, MiniDeps.later

later(function()
    add({
        source = "mfussenegger/nvim-dap",
        depends = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            {
                source = "jay-babu/mason-nvim-dap.nvim",
                depends = {
                    "williamboman/mason.nvim",
                },
            },
        },
    })

    local dap = require("dap")

    require("mason-nvim-dap").setup({
        ensure_installed = {
            "js",
            "php",
        },
    })

    local dapui = require("dapui")
    require("nvim-dap-virtual-text").setup()

    dap.listeners.after.event_initialized.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    utils.n_keymap("<leader>db", dap.toggle_breakpoint, "Toggle [b]reakpoint")
    utils.n_keymap("<leader>du", dapui.toggle, "Toggle debug [U]I")
    utils.n_keymap("<F5>", dap.continue, "Continue")
    utils.n_keymap("<F7>", dap.step_into, "Step into")
    utils.n_keymap("<F8>", dap.step_over, "Step over")
    utils.n_keymap("<F9>", dap.step_out, "Step out")

    -- Set up adapters
    local exists, mason = pcall(require, "mason-registry")

    if not exists then
        return
    end

    -- PHP
    local php_adapter = mason.get_package("php-debug-adapter")

    if php_adapter then
        dap.adapters.php = {
            type = "executable",
            command = "node",
            args = {
                string.format("%s/php-debug-adapter", php_adapter:get_install_path()),
            },
        }

        dap.configurations.php = {
            -- Listen to Xdebug connections
            {
                name = "Listen for Xdebug connections",
                type = "php",
                request = "launch",
                port = 9003,
            },
        }

        vim.notify("Set up Xdebug with DAP")
    end

    -- JavaScript
    local js_adapter = mason.get_package("js-debug-adapter")

    if js_adapter then
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = {
                    string.format("%s/js-debug-adapter", js_adapter:get_install_path()),
                },
            },
        }

        dap.configurations.javascript = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
        }
    end
end)
