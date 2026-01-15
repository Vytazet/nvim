-- Keymap to create a floating terminal window
local state = {
  buf = -1,
  win = -1,
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.4)
  local height = opts.height or math.floor(vim.o.lines * 0.9)

  -- Calculate position (Right Side)
  local col = vim.o.columns - width
  local row = math.floor((vim.o.lines - height) / 2)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(state.buf, true, win_config)
  return win
end

local function toggle_terminal()
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    return
  end

  if not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true) -- Create scratch buffer
  end

  state.win = create_floating_window()

  if vim.bo[state.buf].buftype ~= "terminal" then
    vim.cmd.terminal()
  end

  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>tt", toggle_terminal, { desc = "Toggle Floating Terminal" })
