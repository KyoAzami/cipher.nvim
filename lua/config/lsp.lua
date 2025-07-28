-- lua/config/lsp.lua
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local cmp = require('cmp')
local luasnip = require('luasnip')
local schemastore = require('schemastore')

-- Mason setup
mason.setup({
    ui = {
        border = 'rounded',
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- mason-lspconfig setup
mason_lspconfig.setup({
    ensure_installed = {
        'lua_ls', 'pyright', 'rust_analyzer', 'ts_ls', 'clangd', 'gopls',
        'jdtls', 'kotlin_language_server', 'intelephense', 'cobol_ls',
        'html', 'cssls', 'jsonls', 'yamlls', 'emmet_ls',
        'bashls', 'powershell_es',
        'sqlls', 'sqls',
        'dockerls', 'terraformls', 'tflint', 'vimls'
    },
    automatic_installation = true
})

-- Enhanced autocompletion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem = {
    snippetSupport = true,
    resolveSupport = {
        properties = {
            'documentation',
            'detail'
        }
    }
}

-- nvim-cmp (autocompletion) setup
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    formatting = {
        format = function(entry, vim_item)
            -- Customize how completion items are displayed
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[Snip]',
                buffer = '[Buf]',
                path = '[Path]',
            })[entry.source.name]
            return vim_item
        end,
    },
    window = {
        completion = {
            border = "rounded",

            winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel",
        },
    },
})

-- LuaSnip (snippets) configuration
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

-- Common on_attach function for all LSP servers
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    -- Key mappings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format({ async = true, timeout_ms = 5000 })
    end, opts)

    -- Document highlight
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
        vim.api.nvim_create_autocmd('CursorHold', {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references
        })
    end
end

-- LSP server specific configurations
local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false
                },
                telemetry = { enable = false }
            }
        }
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace"
                }
            }
        }
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = "clippy" },
                procMacro = { enable = true }
            }
        }
    },
    ts_ls = { -- Changed from tsserver to ts_ls for Mason 2.0 compatibility
        settings = {
            completions = { completeFunctionCalls = true },
            javascript = {
                inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true
                }
            }
        }
    },
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--all-scopes-completion",
            "--completion-style=detailed"
        }
    },
    gopls = {
        settings = {
            gopls = {
                analyses = { unusedparams = true, shadow = true },
                staticcheck = true,
                gofumpt = true,
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true
                }
            }
        }
    },
    jdtls = {
        cmd = { 'jdtls' },
        root_dir = lspconfig.util.root_pattern('pom.xml', 'build.gradle', '.git'),
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = 'fernflower' }
            }
        }
    },
    kotlin_language_server = {},
    intelephense = {
        settings = {
            intelephense = {
                files = { maxSize = 5000000 },
                environment = { includePaths = { "**/vendor/**" } },
                diagnostics = { enable = true },
                stubs = {
                    "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
                    "curl", "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter",
                    "fpm", "ftp", "gd", "hash", "iconv", "imap", "intl", "json",
                    "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc",
                    "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql",
                    "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell",
                    "readline", "Reflection", "regex", "session", "SimpleXML", "soap",
                    "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals",
                    "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "xml",
                    "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip",
                    "zlib"
                }
            }
        }
    },
    cobol_ls = {
        cmd = { "cobol-lsp" },
        filetypes = { "cobol" },
        settings = {
            cobol_ls = {
                copybook_dir = { "copybooks", "Copybooks", "COPYBOOKS" },
                target_platform = "zos"
            }
        }
    },
    sqlls = {
        cmd = { "sql-language-server", "up", "--method", "stdio" },
        filetypes = { "sql", "mysql" }
    },
    sqls = {
        settings = {
            sqls = {
                connections = {
                    {
                        driver = "postgresql",
                        dataSourceName =
                        "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=postgres sslmode=disable"
                    }
                }
            }
        }
    },
    html = {
        filetypes = { 'html', 'htmldjango' },
        settings = {
            html = {
                autoClosingTags = true,
                autoCreateQuotes = true,
                autoImportCompletion = true,
                suggest = {
                    html5 = true
                }
            }
        }
    },
    cssls = {
        settings = {
            css = {
                validate = true,
                lint = {
                    unknownAtRules = "ignore"
                }
            },
            scss = {
                validate = true
            },
            less = {
                validate = true
            }
        }
    },
    jsonls = {
        settings = {
            json = {
                schemas = schemastore.json.schemas(),
                validate = { enable = true },
                format = { enable = true }
            }
        }
    },
    yamlls = {
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    ["https://json.schemastore.org/github-action.json"] = "/.github/action.{yml,yaml}",
                    ["https://json.schemastore.org/ansible-playbook.json"] = "playbook.{yml,yaml}",
                    ["https://json.schemastore.org/docker-compose.json"] = "docker-compose.{yml,yaml}",
                    ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}"
                },
                format = { enable = true },
                validate = true,
                completion = true,
                hover = true
            }
        }
    },
    emmet_ls = {
        filetypes = { 'html', 'htmldjango', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
        init_options = {
            html = {
                options = {
                    ["bem.enabled"] = true
                }
            }
        }
    },
    bashls = {
        filetypes = { 'sh', 'bash', 'zsh' },
        settings = {
            bashIde = {
                globPattern = "*@(.sh|.inc|.bash|.command)"
            }
        }
    },
    powershell_es = {
        cmd = {
            vim.fn.stdpath("data") ..
            "/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1"
        },
        filetypes = { "ps1" },
        settings = {
            powershell = {
                codeFormatting = { Preset = "Allman" },
                scriptAnalysis = { enable = true }
            }
        }
    },
    dockerls = {},
    terraformls = {
        filetypes = { "terraform", "tf", "hcl" },
        settings = {
            terraform = {
                format = { enable = true }
            }
        }
    },
    tflint = {
        filetypes = { "terraform", "tf", "hcl" }
    },
    vimls = {}
}

-- Register each LSP server
for server, config in pairs(servers) do
    local final_config = vim.tbl_deep_extend('force', {
        capabilities = capabilities,
        on_attach = on_attach,
    }, config or {})

    lspconfig[server].setup(final_config)
end

-- Diagnostics configuration
vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        spacing = 4,
        source = "if_many",
        format = function(diagnostic)
            return string.format(
                "%s (%s: %s)",
                diagnostic.message,
                diagnostic.source,
                diagnostic.code or diagnostic.user_data.lsp.code
            )
        end,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        format = function(diagnostic)
            return string.format(
                "%s (%s: %s)",
                diagnostic.message,
                diagnostic.source,
                diagnostic.code or diagnostic.user_data.lsp.code
            )
        end,
    },
})

-- Floating diagnostic tooltip
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})

-- Improved signature help display
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "rounded",
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    }
)

-- Improved hover display
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = 80,
        max_height = 30,
    }
)

-- Diagnostic color configuration
vim.cmd([[
  highlight DiagnosticError guifg=#ff6c6b
  highlight DiagnosticWarn guifg=#ECBE7B
  highlight DiagnosticInfo guifg=#98be65
  highlight DiagnosticHint guifg=#4db5bd
  highlight DiagnosticUnderlineError gui=undercurl guisp=#ff6c6b
  highlight DiagnosticUnderlineWarn gui=undercurl guisp=#ECBE7B
  highlight DiagnosticUnderlineInfo gui=undercurl guisp=#98be65
  highlight DiagnosticUnderlineHint gui=undercurl guisp=#4db5bd
]])
