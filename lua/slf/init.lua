local nvim = vim.api
local M = {}

M.defaults = {
  base_folder = os.getenv("HOME") .. "/sync/",
}

M.opts = {}

M.symlink_file = function(opts)
  local file_path = nvim.nvim_buf_get_name(0)

  -- Get the target folder location
  local target_folder = ((opts and opts.base_folder) or M.opts.base_folder) ..
      require "slf.utils".get_buffer_git_relative_folder()

  -- Create the target folder if it does not exist
  if not os.rename(target_folder, target_folder) then
    os.execute("mkdir -p " .. target_folder)
  end

  -- Construct the target file path
  local target_file = target_folder .. "/" .. vim.fn.fnamemodify(file_path, ":t")

  -- Create a symbolic link to the current file
  -- Commented out for now
  -- os.execute("ln -sf " .. file_path .. " " .. target_file)

  vim.pretty_print("synced files. command: ln -sf " .. file_path .. " " .. target_file)

end

M.get_symlink_command = function(opts)
  local file_path = nvim.nvim_buf_get_name(0)
  vim.pretty_print(file_path)

  -- Get the target folder location
  local target_folder = ((opts and opts.base_folder) or M.opts.base_folder) ..
      require "slf.utils".get_buffer_git_relative_folder()

  -- Construct the target file path
  local target_file = target_folder .. "/" .. vim.fn.fnamemodify(file_path, ":t")

  return "ln -sf " .. file_path .. " " .. target_file

end

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end
M.setup()

return M

