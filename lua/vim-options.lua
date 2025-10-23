
-- Create an autocommand group to organize our Dart settings
local dart_augroup = vim.api.nvim_create_augroup('DartSettings', { clear = true })

-- Set indentation to 2 spaces for Dart files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dart',
  group = dart_augroup,
  callback = function()
    -- Set buffer-local options for the current Dart file
    vim.bo.tabstop = 2      -- Number of visual spaces per tab.
    vim.bo.shiftwidth = 2   -- Number of spaces to use for each step of (auto)indent.
    vim.bo.softtabstop = 2  -- Number of spaces a <Tab> counts for.
    vim.bo.expandtab = true -- Use spaces instead of tabs.
  end,
})
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.relativenumber = true
vim.opt.number = true
