local function open_ai_chat_interface()
  local chat_buf_name = '[AI Chat]'
  vim.cmd 'vsplit'
  -- Get the new window number
  local win_id = vim.api.nvim_get_current_win()
  -- Create a new buffer for the chat interface
  local chat_buf = vim.api.nvim_create_buf(false, true) -- Not loaded, scratch buffer
  -- Set buffer options for the chat interface
  vim.api.nvim_buf_set_name(chat_buf, chat_buf_name)
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = chat_buf }) -- Not associated with a file
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = chat_buf }) -- Delete on close
  vim.api.nvim_set_option_value('swapfile', false, { buf = chat_buf }) -- No swap file
  vim.api.nvim_set_option_value('modifiable', true, { buf = chat_buf }) -- Allow modifications

  -- Set window options
  vim.api.nvim_set_option_value('relativenumber', false, { win = win_id })
  vim.api.nvim_set_option_value('number', false, { win = win_id })
  vim.api.nvim_set_option_value('wrap', true, { win = win_id })
  vim.api.nvim_set_option_value('signcolumn', 'no', { win = win_id })
  vim.api.nvim_set_option_value('foldenable', false, { win = win_id })
  vim.api.nvim_set_option_value('winfixwidth', true, { win = win_id }) -- Keep a fixed width for the chat window
  -- Set the buffer for the current window
  vim.api.nvim_win_set_buf(win_id, chat_buf)
  -- Optionally, set a fixed width for the chat window (e.g., 80 columns)
  -- This will try to resize the window to 80 columns.
  vim.cmd 'vertical resize 80'
  -- Insert some initial text (e.g., a welcome message)
  vim.api.nvim_buf_set_lines(chat_buf, 0, -1, false, {
    'Welcome to AI Chat!',
    '-------------------',
    'Type your message below and press Enter.',
    '',
  })
  -- Set cursor to the end of the buffer for immediate input
  vim.api.nvim_win_set_cursor(win_id, { 4, 0 })
end

local function setup()
  vim.keymap.set('n', '<leader>ao', function()
    open_ai_chat_interface()
  end, {
    desc = 'Open AI Chat Interface',
    silent = true,
  })
end

return { setup = setup }
