return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- starts saving when a file is opened
  opts = {
    -- Automatically close Neo-tree before saving the session
    pre_save = function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'PersistenceSavePre' })
      -- Broad closing of sidebars
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
        if ft == 'neo-tree' or ft == 'oil' then
          vim.api.nvim_win_close(win, true)
        end
      end
    end,
  },
  -- Adding keymaps to actually use the sessions!
  keys = {
    -- Restore the session for the current directory
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    -- Restore the last session (regardless of directory)
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    -- Stop persistence (won't save the session on quit)
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}