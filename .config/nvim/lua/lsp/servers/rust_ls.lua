return function(common)
    require('lspconfig').rust_analyzer.setup({
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        settings = {
            ['rust-analyzer'] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = "clippy" },
            },
        },
    })
end
