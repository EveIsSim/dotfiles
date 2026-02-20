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

    --#region diagnostic
    vim.keymap.set("n", "<leader>qf", function()
        vim.diagnostic.setqflist(); vim.cmd("copen")
    end, opts)
    vim.keymap.set("n", "<leader>q", function()
        vim.diagnostic.setqflist({ open = false })
        require("telescope.builtin").diagnostics({
            severity = { min = vim.diagnostic.severity.WARN },
        })
    end)
    --#endregion

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
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
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

-- ── Borders for LSP floating windows (hover/signature/diagnostics) ──
local border = "rounded"

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = border })

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

vim.diagnostic.config({
    virtual_text = true,
    float = { border = border },
})

return M
