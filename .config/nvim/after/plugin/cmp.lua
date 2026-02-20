local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
        }),
    },

    formatting = {
        format = function(entry, vim_item)
            -- icons & types from right (Method/Struct/Interface и т.п.)
            vim_item = lspkind.cmp_format({
                mode = 'symbol_text', -- show icon and type
                maxwidth = 50,
                ellipsis_char = '…',
            })(entry, vim_item)

            -- source from left: [LSP], [SNIP], [BUF], [PATH]
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[SNIP]",
                buffer = "[BUF]",
                path = "[PATH]",
            })[entry.source.name]

            return vim_item
        end
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
    }),
})
