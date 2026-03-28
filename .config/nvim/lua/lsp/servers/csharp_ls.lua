return function(common)
    local refresh_group = vim.api.nvim_create_augroup("user-roslyn-diagnostics", { clear = false })
    local build_namespace = vim.api.nvim_create_namespace("csharp-build-diagnostics")
    local build_state_by_root = {}
    local roslyn_cmd = {
        vim.fn.expand(
            "$HOME/.local/share/roslyn_ls/content/LanguageServer/osx-arm64/Microsoft.CodeAnalysis.LanguageServer"),
        "--logLevel",
        "Information",
        "--extensionLogDirectory",
        vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
        "--stdio",
    }

    local function refresh_diagnostics(client)
        if not client:supports_method(vim.lsp.protocol.Methods.textDocument_diagnostic) then
            return
        end

        for bufnr, _ in pairs(client.attached_buffers) do
            if vim.api.nvim_buf_is_loaded(bufnr) then
                client:request(
                    vim.lsp.protocol.Methods.textDocument_diagnostic,
                    { textDocument = vim.lsp.util.make_text_document_params(bufnr) },
                    nil,
                    bufnr
                )
            end
        end
    end

    local function parse_build_line(line)
        local patterns = {
            "^(.-)%((%d+),(%d+)%)%s*:%s*(%a+)%s+([%w%d]+)%s*:%s*(.-)%s*%[.-%]$",
            "^(.-)%((%d+),(%d+)%)%s*:%s*(%a+)%s+([%w%d]+)%s*:%s*(.+)$",
            "^(.-):(%d+):(%d+):%s*(%a+)%s+([%w%d]+):%s*(.+)$",
        }

        for _, pattern in ipairs(patterns) do
            local filename, lnum, col, severity, code, message = line:match(pattern)
            if filename and lnum and col and severity and code and message then
                local build_severity = severity:lower() == "warning" and vim.diagnostic.severity.WARN
                    or vim.diagnostic.severity.ERROR

                return vim.fn.fnamemodify(filename, ":p"), {
                    lnum = tonumber(lnum) - 1,
                    col = tonumber(col) - 1,
                    severity = build_severity,
                    source = "dotnet build",
                    code = code,
                    message = string.format("%s: %s", code, vim.trim(message)),
                }
            end
        end
    end

    local function publish_build_diagnostics(root, output)
        local per_file = {}
        local current_bufs = {}
        local state = build_state_by_root[root]

        for line in output:gmatch("[^\r\n]+") do
            local filename, diagnostic = parse_build_line(line)
            if filename and diagnostic then
                per_file[filename] = per_file[filename] or {}
                table.insert(per_file[filename], diagnostic)
            end
        end

        for filename, diagnostics in pairs(per_file) do
            local bufnr = vim.fn.bufadd(filename)
            current_bufs[bufnr] = true
            vim.diagnostic.set(build_namespace, bufnr, diagnostics)
        end

        for bufnr, _ in pairs(state.seen_bufs) do
            if not current_bufs[bufnr] then
                vim.diagnostic.reset(build_namespace, bufnr)
            end
        end

        state.seen_bufs = current_bufs
    end

    local function begin_progress(root)
        local ok, progress = pcall(require, "fidget.progress")
        if not ok then
            return
        end

        local state = build_state_by_root[root]
        if state.handle then
            state.handle:report({
                title = "C# reanalysis",
                message = "Running dotnet build...",
                percentage = 0,
            })
            return
        end

        state.handle = progress.handle.create({
            title = "C# reanalysis",
            message = "Running dotnet build...",
            lsp_client = { name = "csharp_build" },
            percentage = 0,
        })
    end

    local function report_progress(root, message, percentage)
        local state = build_state_by_root[root]
        if state and state.handle then
            state.handle:report({
                title = "C# reanalysis",
                message = message,
                percentage = percentage,
            })
        end
    end

    local function finish_progress(root, message)
        local state = build_state_by_root[root]
        if state and state.handle then
            state.handle:report({
                title = "C# reanalysis",
                message = message,
                percentage = 100,
            })
            state.handle:finish()
            state.handle = nil
        end
    end

    local function run_build(root)
        if vim.fn.executable("dotnet") ~= 1 then
            return
        end

        local state = build_state_by_root[root]
        if not state then
            state = { running = false, rerun = false, seen_bufs = {} }
            build_state_by_root[root] = state
        end

        if state.running then
            state.rerun = true
            report_progress(root, "Queued another run...", 15)
            return
        end

        state.running = true
        state.rerun = false
        begin_progress(root)

        vim.system({
            "dotnet",
            "build",
            "--nologo",
            "--verbosity",
            "minimal",
        }, {
            cwd = root,
            text = true,
        }, function(result)
            local output = (result.stdout or "") .. "\n" .. (result.stderr or "")

            vim.schedule(function()
                publish_build_diagnostics(root, output)
                local diagnostics = vim.diagnostic.get(nil, { namespace = build_namespace })
                if result.code == 0 and #diagnostics == 0 then
                    finish_progress(root, "Build clean")
                else
                    finish_progress(root, string.format("Found %d build diagnostic(s)", #diagnostics))
                end

                state.running = false
                if state.rerun then
                    run_build(root)
                end
            end)
        end)
    end

    local function on_attach(client, bufnr)
        common.on_attach(client, bufnr)
        local root = client.config.root_dir

        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
            group = refresh_group,
            buffer = bufnr,
            callback = function()
                refresh_diagnostics(client)
                if type(root) == "string" and root ~= "" then
                    run_build(root)
                end
            end,
            desc = "Refresh roslyn diagnostics",
        })
    end

    local capabilities = vim.tbl_deep_extend("force", common.capabilities, {
        textDocument = {
            diagnostic = {
                dynamicRegistration = true,
            },
        },
    })

    vim.lsp.config('roslyn_ls', {
        on_attach = on_attach,
        cmd = roslyn_cmd,
        capabilities = capabilities,
        settings = {
            ['csharp|background_analysis'] = {
                dotnet_analyzer_diagnostics_scope = 'fullSolution',
                dotnet_compiler_diagnostics_scope = 'fullSolution',
            },
            ['csharp|completion'] = {
                dotnet_show_name_completion_suggestions = true,
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_provide_regex_completions = true,
            },
            ['csharp|symbol_search'] = {
                dotnet_search_reference_assemblies = true,
            },
            ['csharp|code_lens'] = {
                dotnet_enable_references_code_lens = true,
            },
        },
    })

    vim.lsp.enable('roslyn_ls')
end
