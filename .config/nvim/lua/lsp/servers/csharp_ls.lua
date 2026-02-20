return function(common)
    local util = require('lspconfig.util')

    vim.lsp.config('omnisharp', {
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        cmd = {
            "dotnet",
            vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll",
            "--languageserver",
            "--hostPID",
            tostring(vim.fn.getpid()),
        },

        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = util.root_pattern('*.sln', '*.csproj', '.git')(fname)
            on_dir(root or vim.fn.getcwd())
        end,

        handlers = {
            ['textDocument/definition'] = function(...)
                local ok, ext = pcall(require, 'omnisharp_extended')
                if ok then
                    return ext.handler(...)
                end
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

    vim.lsp.enable('omnisharp')
end
