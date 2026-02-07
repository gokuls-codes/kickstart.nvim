return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    options = {
      theme = 'auto',
      globalstatus = true,
    },
    sections = {
      lualine_x = {
        {
          function() return '🌊 ' .. vim.fn['codeium#GetStatusString']() end,
          color = { fg = '#61afef' },
        },
        'encoding',
        'fileformat',
        'filetype',
      },
    },
  },
}
