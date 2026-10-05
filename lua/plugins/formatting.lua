return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- Run ruff organize imports first, then ruff format
        python = { "ruff_organize_imports", "ruff_format" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
      -- Format on save configuration
      format_on_save = {
        lsp_fallback = true, -- Fall back to LSP formatting if formatter isn't installed
        async = false,
        timeout_ms = 1000,
      },
    })

    -- Optional keymap to trigger formatting manually
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range" })
  end,
}
