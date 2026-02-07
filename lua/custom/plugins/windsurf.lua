return {
  'Exafunction/windsurf.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- "hrsh7th/nvim-cmp",
  },
  config = function()
    require('codeium').setup {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        manual = true,
      },
    }
    vim.keymap.set('i', '<M-f>', function() return require('codeium.virtual_text').complete() end, { expr = true, silent = true, desc = 'Codeium: Accept' })
  end,
}
