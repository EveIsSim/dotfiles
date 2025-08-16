local builtin = require('telescope.builtin')
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
})
