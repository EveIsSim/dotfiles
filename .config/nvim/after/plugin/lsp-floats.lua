-- Force borders for ALL LSP floating previews (hover/signature/etc.)
do
    local orig = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig(contents, syntax, opts, ...)
    end
end

vim.diagnostic.config({
    float = { border = "rounded" },
})
