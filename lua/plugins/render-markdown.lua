return {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        -- ---@module 'render-markdown'
        -- ---@type render.md.UserConfig
        -- opts = {},
        config = function()
            local builtin = require("render-markdown")
            builtin.setup({
                completions = { lsp = { enabled = true } },
            })
            vim.keymap.set("n", "<leader>md", builtin.toggle, {desc= "Enable 'Render Markdown'."})
            vim.keymap.set("n", "<leader>mdl", builtin.log, {desc= "Opens the log file for this plugin."})
            vim.keymap.set("n", "<leader>mde", builtin.expand, {desc= "Increase anti-conceal margin above and below by 1."})
            vim.keymap.set("n", "<leader>mdc", builtin.contract, {desc= "Decrease anti-conceal margin above and below by 1."})
        end
}
