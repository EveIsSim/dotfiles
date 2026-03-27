local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

nvim_tree.setup({
    hijack_netrw = false,
    view = {
        width = 38,
    },
    filters = {
        dotfiles = false,
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    update_focused_file = {
        enable = true,
        update_root = false,
    },
})

vim.api.nvim_create_user_command("ProjectTree", function()
    require("nvim-tree.api").tree.toggle()
end, {})

vim.api.nvim_create_user_command("ProjectTreeFind", function()
    require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, {})

vim.keymap.set("n", "<leader>nn", "<cmd>ProjectTree<CR>", { silent = true, desc = "Toggle project tree" })
vim.keymap.set("n", "<leader>nf", "<cmd>ProjectTreeFind<CR>",
    { silent = true, desc = "Reveal current file in project tree" })
