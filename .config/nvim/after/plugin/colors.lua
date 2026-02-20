return {
    {
        "vague-theme/vague.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd.colorscheme("vague")

            vim.api.nvim_set_hl(0, "FloatBorder", { link = "NonText" })
        end,
    },
}
