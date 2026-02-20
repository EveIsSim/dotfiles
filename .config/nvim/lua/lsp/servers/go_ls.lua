return function(common)
    vim.lsp.config('gopls', {
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        settings = {
            gopls = {
                usePlaceholders = true,
                analyses = { unusedparams = true, nilness = true, shadow = true },
            },
        },
    })

    vim.lsp.enable('gopls')
end
