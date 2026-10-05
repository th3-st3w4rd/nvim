-- return {
--     {
--         "williamboman/mason.nvim",
--         config = function()
--             require("mason").setup()
--         end
--     },
--     {
--         "williamboman/mason-lspconfig.nvim",
--         dependencies = { "neovim/nvim-lspconfig" }, -- Ensures nvim-lspconfig patterns are loaded first
--         config = function()
--             require("mason-lspconfig").setup({
--                 ensure_installed = {
--                     "lua_ls",
--                     "superhtml",
--                     "marksman",
--                     "jedi_language_server",
--                     "harper_ls",
--                     "lemminx",
--                     "hydra_lsp",
--                     "ruff",
--                     "pyright"
--                 },
--                 -- Automatically handle setup for all mason-installed servers using Neovim 0.11+ API
--                 handlers = {
--                     function(server_name)
--                         vim.lsp.enable(server_name)
--                     end,
--                     -- Provide custom settings for specific servers if needed
--                     ["lua_ls"] = function()
--                         vim.lsp.config("lua_ls", {
--                             opts = {
--                                 settings = {
--                                     Lua = {
--                                         diagnostics = { globals = { "vim" } }
--                                     }
--                                 }
--                             }
--                         })
--                         vim.lsp.enable("lua_ls")
--                     end,
--                 }
--             })
--         end
--     },
--     {
--         "neovim/nvim-lspconfig",
--         config = function()
--             -- Diagnostic keymap can sit outside the autocommand
--             vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
--
--             -- Global LspAttach autocommand for keymaps and buffer options
--             vim.api.nvim_create_autocmd("LspAttach", {
--                 group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--                 callback = function(ev)
--                     vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--                     local opts = { buffer = ev.buf }
--
--                     vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
--                     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--                     vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--                     vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--                     vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
--                     vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
--                     vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
--                     vim.keymap.set("n", "<leader>wl", function()
--                         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--                     end, opts)
--                     vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
--                     vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--                     vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
--                     vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--                     vim.keymap.set("n", "<leader>f", function()
--                         vim.lsp.buf.format { async = true }
--                     end, opts)
--                 end,
--             })
--         end,
--     },
-- }

return {
    -- 1. Mason Base Tool
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {},
    },

    -- 2. LSP Configuration + Mason Bridge
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp", -- Tells LSP server about cmp's auto-completion capabilities
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason").setup()

            mason_lspconfig.setup({
                ensure_installed = {
                    "pyright", -- Core Python language server
                    "ruff",    -- Fast Python linter & code organizer
                    "lua_ls",  -- Lua
                    "html",    -- HTML
                    "superhtml",
                    "marksman",
                    "jedi_language_server",
                    "harper_ls",
                    "lemminx",
                    "hydra_lsp",
                    "pyright"
                },
                automatic_installation = true,
                -- Pass handlers directly inside setup() instead of calling setup_handlers()
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,

                    -- Custom Pyright settings for Django/Python
                    ["pyright"] = function()
                        lspconfig.pyright.setup({
                            capabilities = capabilities,
                            settings = {
                                python = {
                                    analysis = {
                                        autoSearchPaths = true,
                                        useLibraryCodeForTypes = true,
                                        diagnosticMode = "workspace",
                                        typeCheckingMode = "basic",
                                    },
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },

    -- 3. Autocompletion Engine & Sources
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
}
