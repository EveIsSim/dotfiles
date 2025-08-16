return function(common)
    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')

    lspconfig.lua_ls.setup({
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        root_dir = function(fname)
            return util.root_pattern('.luarc.json', '.luarc.jsonc', '.git')(fname) or vim.fn.getcwd()
        end,
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    })
end
