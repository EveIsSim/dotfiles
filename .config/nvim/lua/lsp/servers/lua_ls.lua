return function(common)
    local util = require('lspconfig.util')

    vim.lsp.config('lua_ls', {
        on_attach = common.on_attach,
        capabilities = common.capabilities,

        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = util.root_pattern('.luarc.json', '.luarc.jsonc', '.git')(fname)
            on_dir(root or vim.fn.getcwd())
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

    vim.lsp.enable('lua_ls')
end
