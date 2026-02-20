local function make_transparent()
    -- Fidget highlights (notification window)
    local fidget_groups = {
        "FidgetTitle",
        "FidgetTask",
        "FidgetIcon",
        "FidgetProgress",
        "FidgetBackground",
    }

    for _, g in ipairs(fidget_groups) do
        pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
    end

    -- Basic nvim + lsp
    local groups = {
        "Normal", "NormalNC", "SignColumn", "EndOfBuffer",
        "WinSeparator", "VertSplit",
    }

    for _, g in ipairs(groups) do
        vim.api.nvim_set_hl(0, g, { bg = "none" })
    end

    -- if need transparent float windows:
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
end

-- apply once
make_transparent()

-- and aply after theme
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.defer_fn(make_transparent, 1)
    end,
})
