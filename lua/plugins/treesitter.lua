return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
                "bash",
                "css",
                "csv",
                "gitcommit",
                "gitignore",
                "go",
                "html",
                "htmldjango",
                "http",
                "json",
                "lua",
                "markdown",
                "python",
                "robots",
                "ruby",
                "vim",
                "xml",
                "yaml",
			},
			highlight = { enable = true },
			indent = { enable = true }
		})
	end
}
