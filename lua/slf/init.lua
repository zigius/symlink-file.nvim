local nvim = vim.api
local M = {}

M.defaults = {
  base_folder = os.getenv("HOME") .. "/sync",
}

M.opts = {}

M.symlink_file = function(opts)

  -- Get the current buffer and its file path
  local buffer = nvim.buf_get_current()
  local file_path = nvim.buf_get_name(buffer)

  -- Get the target folder location

  local buffer_relative_folder = require "slf.utils".get_buffer_git_relative_folder()
  local target_folder = ((opts and opts.base_folder) or M.opts.base_folder) .. buffer_relative_folder

  -- Create the target folder if it does not exist
  if not os.rename(target_folder, target_folder) then
    os.execute("mkdir -p " .. target_folder)
  end

  -- Construct the target file path
  local target_file = target_folder .. "/" .. nvim.fn.fnamemodify(file_path, ":t")

  -- Create a symbolic link to the current file
  -- Commented out for now
  -- os.execute("ln -sf " .. file_path .. " " .. target_file)

  vim.pretty_print("synced files. command: ln -sf " .. file_path .. " " .. target_file)

end

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
