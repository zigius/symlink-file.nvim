local M = {}
local reload = require "plenary.reload"

M.test_get_symlink_command = function()
  reload.reload_module("slf")

  -- Get the path of the root git repository
  require "slf".setup {
    base_folder = os.getenv("HOME") .. "/workspace/"
  }
  local symlink_file_command = require "slf".get_symlink_command()
  vim.pretty_print(symlink_file_command)

  local result = symlink_file_command == "ln -sf " .. os.getenv("HOME") .. "/.vim/plugged/symlink-file.nvim/lua/tests/test_slf.lua " .. os.getenv("HOME") .. "/workspace/lua/tests/test_slf.lua"
  return result
end

vim.pretty_print(M.test_get_symlink_command()) -- should print true
return M
