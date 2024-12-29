local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = lsp.cmp_action()

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'rust_analyzer',
        'gopls',
        'omnisharp'
    },
    automatic_installation = true,
    handlers = {
        lsp.default_setup,
        omnisharp = function()
            require('lspconfig').omnisharp.setup({
                handlers = {
                    ["textDocument/definition"] = require('omnisharp_extended').handler,
                }
            })
        end,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})

-- C#
require('lspconfig').omnisharp.setup({
    cmd = { "omnisharp" },
    enable_editorconfig_support = true,
    enable_import_completion = true,
    organize_imports_on_format = true,
})

-- C# endregion

cmp.setup({
    sources = {
        { name = 'nvim_lsp' }

    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp_action.luasnip_jump_backward(),
        ['<C-n>'] = cmp_action.luasnip_jump_forward(),
        ['<CR>'] = cmp.mapping.confirm({
            bahavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        }),
        ['<S-Tab>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        })
    })
})


lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-l>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>q", function()
        vim.diagnostic.setqflist()
        vim.cmd("copen")
    end, { noremap = true, silent = true })

    -- autoformatting before saving
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
