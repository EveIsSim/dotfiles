-- ###### Setup Go
vim.g["test#go#runner"] = "richgo"
-- ###### setup Go

-- ###### Common
vim.g["test#strategy"] = "neovim" -- run in dynamic window neovim
-- vim.g["test#strategy"] = "basic" -- run in a new terminal split below

-- Keybindigs
vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ts", ":TestSuite<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tv", ":TestVisit<CR>", { noremap = true, silent = true })

-- ###### Common
