return function(common)
    local util = require('lspconfig.util')
    local lspconfig = require('lspconfig')

    lspconfig.omnisharp.setup({
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        cmd = {
            "dotnet",
            vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll",
            "--languageserver",
            "--hostPID",
            tostring(vim.fn.getpid()),
        },
        root_dir = util.root_pattern('*.sln', '*.csproj', '.git') or vim.fn.getcwd(),
        handlers = {
            ['textDocument/definition'] = function(...)
                local ok, ext = pcall(require, 'omnisharp_extended')
                if ok then return ext.handler(...) end
                return vim.lsp.handlers['textDocument/definition'](...)
            end,
        },
        enable_editorconfig_support = true,
        enable_import_completion = true,
        organize_imports_on_format = true,
        settings = {
            RoslynExtensionsOptions = {
                EnableAnalyzersSupport = true,
                EnableImportCompletion = true,
                EnableDecompilationSupport = true,
            },
        },
    })
end
