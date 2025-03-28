return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "superhtml",
                    "marksman",
                    "jedi_language_server",
                    "textlsp",
                    "harper_ls",
                    "lemminx",
                    "hydra_lsp",
                }
            })
        end
    },

}
