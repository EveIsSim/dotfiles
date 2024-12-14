local dap = require("dap")
local dapgo = require("dap-go")

-- ###### setup Go
dapgo.setup() -- auto setup debugger Delve

-- ##### setup Csharp
dap.adapters.coreclr = {
  type = "executable",
  command = "/usr/local/netcoredbg",
  args = { "--interpreter=vscode" }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch - NetCoreDbg",
        request = "launch",
        program = function()
            -- recurcive searching all DLLs
            local dlls = vim.fn.glob(vim.fn.getcwd() .. "/**/bin/Debug/net*/*.dll", 0, 1)

            if #dlls == 0 then
                vim.notify("No DLLs found in the project.", vim.log.levels.ERROR)
                return nil
            elseif #dlls == 1 then
                vim.notify("Selected DLL: " .. dlls[1], vim.log.levels.INFO)
                return dlls[1]
            else
                local dll_list = table.concat(dlls, "\n")
                local choice = vim.fn.inputlist({"Select DLL:", dll_list})
                if choice < 1 or choice > #dlls then
                    vim.notify("Invalid choice. Canceling debug.", vim.log.levels.ERROR)
                    return nil
                end
                return dlls[choice]
            end
        end,
    },
}
-- ##### setup Csharp

-- ###### setup dapui
local dapui = require("dapui")
dapui.setup()

-- open/close UI when start/stop debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup()
require("telescope").load_extension("dap")

-- ###### setup dapui

-- ###### setup mapping
vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dr", ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>", { noremap = true, silent = true })

-- ###### setup mapping

