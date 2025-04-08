return {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        local peek = require("peek")
        peek.setup({
            vim.api.nvim_create_user_command("PeekOpen", peek.open, {}),
            vim.api.nvim_create_user_command("PeekClose",peek.close, {}),
            vim.keymap.set("n", "<leader>po", peek.open, { desc = "[P]eek [O]pens markdown file preview." }),
            vim.keymap.set("n", "<leader>pc", peek.close, { desc = "[P]eek [C]loses markdown file preview." }),

        })
    end,
}
