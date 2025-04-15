return {

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',

        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Search by [L]ive [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'Search for [O]ld [F]iles ("." for repeat)' })
            --vim.keymap.set('n', '<leader>fb', builtin.file_browser, { desc = 'Opens [F]ile [B]rowser' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        end

    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            -- This is your opts table
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }

                        -- pseudo code / specification for writing custom displays, like the one
                        -- for "codeactions"
                        -- specific_opts = {
                        --   [kind] = {
                        --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                        --     make_display = function(displayer) -> function(e)
                        --     make_ordinal = function(e) -> string
                        --   },
                        --   -- for example to disable the custom builtin "codeactions" display
                        --      do the following
                        --   codeactions = false,
                        -- }
                    }
                }
            })
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            --local tsbrowser = require("telescope")
            --tsbrowser.setup({
            --local fb_actions = require "telescope.extensions.file_browser.actions"
            -- local fb_picker = require "telescope.exntensions.file_browser.picker"
            require("telescope").setup({
                -- You don't need to set any of these options.
                -- IMPORTANT!: this is only a showcase of how you can set default options!

                extensions = {
                    file_browser = {
                        theme = "cattpuccin",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                            },
                            ["n"] = {
                                --["<leader>fb"] = fb_picker.file_browser, -- your custom normal mode mappings
                            },
                        },
                    },
                },
            })
            -- To get telescope-file-browser loaded and working with telescope,
            -- you need to call load_extension, somewhere after setup function:
            require("telescope").load_extension("file_browser")
        end
    },
}
