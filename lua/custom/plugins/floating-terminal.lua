vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

---Creates a centered floating window in Neovim
---@param opts table|nil Optional parameters: { width = number, height = number }
---@return table
local function create_floating_window(opts)
  opts = opts or {}

  -- Get the current editor's total dimensions
  local total_width = vim.o.columns
  local total_height = vim.o.lines

  -- Determine the window size
  -- Default to 80% of the screen if not provided
  local width = opts.width or math.floor(total_width * 0.6)
  local height = opts.height or math.floor(total_height * 0.6)

  -- Calculate the position to center the window
  -- (Total - Window) / 2 gives the starting offset
  local col = math.floor((total_width - width) / 2)
  local row = math.floor((total_height - height) / 2)

  local buf = nil

  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    -- Create a new scratch buffer (non-file, wipe on delete)
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Configure the window options
  local win_config = {
    title = 'Floating terminal',
    relative = 'editor', -- Position relative to the whole editor
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal', -- Disables number lines, sign column, etc.
    border = 'rounded', -- Adds a nice border
  }

  -- Create the window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- Example usage commands if this file is sourced:
-- :lua require('floating_window').create_floating_window()
-- :lua require('floating_window').create_floating_window({ width = 40, height = 10 })
--

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then vim.cmd.terminal() end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('Fterm', toggle_terminal, {})

vim.keymap.set({ 'n', 't' }, '<space>ft', toggle_terminal)

-- to execute: :source ~/.config/nvim/lua/custom/plugins/floating-terminal.lua
