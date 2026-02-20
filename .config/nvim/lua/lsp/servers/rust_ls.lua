return function(common)
    vim.lsp.config('rust_analyzer', {
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        settings = {
            ['rust-analyzer'] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = "clippy" },
            },
        },
    })

    vim.lsp.enable('rust_analyzer')
end
