vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"
vim.opt.mouse = "a"

local ts_fold_filetypes = {
    "json",
    "jsonc",
    "yaml",
    "javascript",
    "typescript",
    "markdown",
    "go",
    "lua",
    "rust",
    "sh",
    "cs",
}

local ts_foldexpr = "nvim_treesitter#foldexpr()"
if vim.treesitter and vim.treesitter.foldexpr then
    ts_foldexpr = "v:lua.vim.treesitter.foldexpr()"
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = ts_fold_filetypes,
    callback = function()
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = ts_foldexpr
    end,
})
