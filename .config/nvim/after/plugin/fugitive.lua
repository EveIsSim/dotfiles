vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", "<leader>gp", vim.cmd.Gpull);
vim.keymap.set("n", "<leader>gdi", vim.cmd.Gvdiff);
vim.keymap.set("n", "<leader>gl", "<cmd>Gclog!<CR>");
vim.keymap.set("n", "<leader>gc", "<cmd>Gvdiffsplit!<CR>")
vim.keymap.set("n", "<leader>gmt", "<cmd>Git mergetool<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>")

vim.cmd("hi diffAdded ctermfg=188 ctermbg=64 cterm=bold guifg=#50FA7B guibg=NONE gui=bold")
vim.cmd("hi diffAdded ctermfg=188 ctermbg=64 cterm=bold guifg=#50FA7B guibg=NONE gui=bold")
