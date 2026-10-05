return {
  -- 1. LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Tells LSP server about cmp's auto-completion capabilities
    },
    config = function()
      local lspconfig = require("lspconfig")
      -- Get default capabilities expanded with cmp support
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- List the LSP servers you use here
      local servers = { "lua_ls", "pyright", "ts_ls", "clangd", "html" }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
    end,
  },

  -- 2. Autocompletion Engine & Sources
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Load cmp when entering Insert mode
    dependencies = {
      -- Completion sources
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "hrsh7th/cmp-buffer",   -- Text inside current buffer
      "hrsh7th/cmp-path",     -- File system paths

      -- Snippet Engine (Required by nvim-cmp)
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Snippet collection (VS Code style snippets)
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly-snippets VS Code format
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
          ["<C-Space>"] = cmp.mapping.complete(), -- Trigger popup manually
          ["<C-e>"] = cmp.mapping.abort(),        -- Close popup
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item

          -- Super-tab behavior for cycling through completions and snippets
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
        -- Source priority order in the popup menu
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
