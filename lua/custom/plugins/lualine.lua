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
          function()
            local status = require('codeium.virtual_text').status()

            if status.state == 'idle' then
              -- Output was cleared, for example when leaving insert mode
              return '🌊' .. 'Idle'
            end

            if status.state == 'waiting' then
              -- Waiting for response
              return '🌊' .. 'Waiting...'
            end

            if status.state == 'completions' and status.total > 0 then return '🌊' .. string.format('%d/%d', status.current, status.total) end

            return '🌊' .. ' 0 '
          end,
          color = { fg = '#61afef' },
        },

        'encoding',
        'fileformat',
        'filetype',
      },
    },
  },
}

