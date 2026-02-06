return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    settings = {
      -- "change"|"insert_leave" determine when the diagnostics are published
      publish_diagnostic_on = 'insert_leave',
      -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
      -- "remove_unused_imports"|"organize_imports")
      expose_as_code_action = 'all',
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = true,
    },
  },
  config = function(_, opts)
    require('typescript-tools').setup(opts)

    -- Custom keymaps for typescript files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      callback = function(event)
        local buf = event.buf
        vim.keymap.set('n', 'gd', '<cmd>TSToolsGoToSourceDefinition<cr>', { buffer = buf, desc = 'LSP: [G]oto Source [D]efinition' })
        vim.keymap.set('n', 'gb', '<C-o>', { desc = '[G]o [B]ack to previous jump' })
      end,
    })
  end,
}
