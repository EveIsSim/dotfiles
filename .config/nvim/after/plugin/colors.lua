function ColorMyPencils(color)
    color = color or "rose-pine"
    -- color = color or "catppuccin"

    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, "Visual", { bg = "#3e4451", fg = "none" })
    vim.api.nvim_set_hl(0, "Comment", { fg = "#7d8799", italic = true })

    vim.api.nvim_set_hl(0, "Cursor", { bg = "#7d8799", fg = "none" })
    -- vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#f6c177", fg = "#1e1e2e" })
end

ColorMyPencils()
