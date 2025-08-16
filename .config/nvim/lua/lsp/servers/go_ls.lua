return function(common)
    require('lspconfig').gopls.setup({
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        settings = {
            gopls = {
                usePlaceholders = true,
                analyses = { unusedparams = true, nilness = true, shadow = true },
            },
        },
    })
end
