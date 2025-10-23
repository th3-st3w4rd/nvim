  return
    {
      'nvim-flutter/flutter-tools.nvim',
      dependencies = {
          'mfussenegger/nvim-dap', -- Required for debugging
          'rcarriga/nvim-dap-ui', -- Optional, for a UI around nvim-dap
      },
      ft = 'dart', -- Load the plugin when opening Dart files
      config = function()
          require('flutter-tools').setup {
              -- Your Flutter-Tools configuration options here
          }
      end
  }
