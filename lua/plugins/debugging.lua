local utils = require("utils")
local add, later = MiniDeps.add, MiniDeps.later

---@param paths table<integer, string>
---@return string|nil
local function get_first_vscode_xdebug_path(paths)
    for _, path in pairs(paths) do
        local file = string.format("%s/out/phpDebug.js", path)

        if vim.fn.filereadable(file) then
            return file
        end
    end

    return nil
end

---@return table<integer, string>
local function get_possible_vscode_xdebug_paths()
    return {
        -- Installed through Devenv
        ".devenv/profile/share/vscode/extensions/xdebug.php-debug",
    }
end

later(function()
    add({
        source = "mfussenegger/nvim-dap",
        depends = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
    })

    local dap = require("dap")
    dap.setup({})

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
    local php_debug_js_path = get_first_vscode_xdebug_path(get_possible_vscode_xdebug_paths())

    if php_debug_js_path ~= nil then
        dap.adapters.php = {
            type = "executable",
            command = "node",
            args = { php_debug_js_path },
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
end)
