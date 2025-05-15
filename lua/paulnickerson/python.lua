-- Configuration to help with editing python code

-- Variable to store the last used arguments (persists during the Neovim session)
_G.last_python_args = ""

-- Function to run the current Python file with arguments
function _G.run_python_with_args()
  -- Check if the current file is a Python file
  local file_ext = vim.fn.expand('%:e')
  if file_ext ~= 'py' then
    print("Not a Python file")
    return
  end

  -- Prompt for arguments with the last used args as default
  vim.ui.input({
    prompt = "Enter arguments for Python script: ",
    default = _G.last_python_args, -- Use the last arguments as default
  }, function(input)
    if input then
      -- Save the arguments for next time
      _G.last_python_args = input
      
      -- Get the current file path and escape it
      local file_path = vim.fn.expand('%:p')
      
      -- Create the command to run the Python file with the provided arguments
      local cmd = string.format("terminal python3 %s %s", vim.fn.shellescape(file_path), input)
      
      -- Open a new split window at the bottom and run the terminal command
      vim.cmd("botright split")
      vim.cmd(cmd)
      
      -- Set local options and mappings for the terminal buffer
      vim.cmd([[
        setlocal nonumber
        setlocal norelativenumber
        setlocal signcolumn=no
        setlocal bufhidden=hide
        nnoremap <buffer> q :q<CR>
        tnoremap <buffer> <Esc> <C-\><C-n>
      ]])
    end
  end)
end

-- Map the function to a hotkey (e.g., F5)
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua run_python_with_args()<CR>', {noremap = true, silent = true})
