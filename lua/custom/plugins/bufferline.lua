return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers', -- show open buffers
        separator_style = 'slant', -- "slant" | "slope" | "thick" | "thin"
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'left',
            separator = true,
          },
        },
      },
    }

    -- Keymaps to navigate tabs
    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next Tab' })
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Tab' })
    vim.keymap.set('n', '<leader>x', '<Cmd>bd<CR>', { desc = 'Close Buffer' })
  end,
}

