local builtin = require('telescope.builtin')

-- keymaps
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set("n", "<leader>rr", "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- safe load telescope
local ok, telescope = pcall(require, 'telescope')
if not ok then
    return
end

local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"]             = actions.preview_scrolling_up,
                ["<C-d>"]             = actions.preview_scrolling_down,
                -- optional: mouse scroll
                ["<ScrollWheelUp>"]   = actions.preview_scrolling_up,
                ["<ScrollWheelDown>"] = actions.preview_scrolling_down,
            },
            n = {
                ["<C-u>"]             = actions.preview_scrolling_up,
                ["<C-d>"]             = actions.preview_scrolling_down,
                ["<ScrollWheelUp>"]   = actions.preview_scrolling_up,
                ["<ScrollWheelDown>"] = actions.preview_scrolling_down,
            },
        },
    },
    pickers = {
        lsp_references = {
            show_line        = true,
            fname_width      = 80,
            trim_text        = true,
            path_display     = { shorten = { len = 2, exclude = { -1, -2, -3 } } },
            -- len = 2  → use only 2 symbols `sr/pr/DoSmth.cs`
            -- exclude = { -1, -2, -3 }  → display full name for next parts of path from end.

            disable_devicons = true,
            entry_prefix     = "",
            results_title    = false,
            prompt_title     = false,

            layout_strategy  = "vertical",
            layout_config    = {
                width = 0.75,
                height = 0.9,
                preview_cutoff = 0,
                preview_height = 0.6,
                prompt_position = "top",
            },
            initial_mode     = "normal",
        },
        diagnostics = {
            show_line        = true,
            wrap_results     = true,
            fname_width      = 60,
            path_display     = { shorten = { len = 1, exclude = { -1 } } },
            disable_devicons = true,
            entry_prefix     = "",
            results_title    = false,
            prompt_title     = false,
            layout_strategy  = "vertical",
            layout_config    = {
                width = 0.75,
                height = 0.9,
                preview_cutoff = 0,
                preview_height = 0.6,
                prompt_position = "top",
            },
            initial_mode     = "normal",
            sorting_strategy = "ascending",
        },
    },
})

vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function()
        vim.wo.number = true
        vim.wo.relativenumber = false
        vim.wo.cursorline = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    callback = function() vim.wo.wrap = true end,
})
