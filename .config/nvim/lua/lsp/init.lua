local lsp_zero = require('lsp-zero')

-- common on_attach и capabilities
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function on_attach(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-l>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>q", function()
        vim.diagnostic.setqflist(); vim.cmd("copen")
    end, opts)

    -- format before saving (without locking)
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
        end,
    })
end

cmp.setup({
    sources = { { name = 'nvim_lsp' } },
    window = { documentation = cmp.config.window.bordered() },
    mapping = cmp.mapping.preset.insert({
        ['<CR>']      = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>']     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<S-Tab>']   = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-n>']     = cmp_action.luasnip_jump_forward(),
        ['<C-p>']     = cmp_action.luasnip_jump_backward(),
    }),
})

-- export for language models
local M = {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'gopls', 'rust_analyzer', 'omnisharp' },
    automatic_enable = false,
})

-- attach language models
require('lsp.servers.lua_ls')(M)
require('lsp.servers.go_ls')(M)
require('lsp.servers.rust_ls')(M)
require('lsp.servers.csharp_ls')(M)

-- global
vim.diagnostic.config({ virtual_text = true })

return M
