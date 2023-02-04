local nvim = vim.api
local M = {}

M.defaults = {
  base_folder = os.getenv("HOME") .. "/sync/",
  -- symbolic link or hard link. 
  -- I use hardlink by default. To use symbolic links pass "-sf " or "-s ".
  -- !!IMPORTANT!! - Add a space after the flags you want to pass
  ln_flags = "",
}

M.opts = {}

M.symlink_file = function(opts)

  -- Get the target folder location
  local target_folder = ((opts and opts.base_folder) or M.opts.base_folder) ..
      require "slf.utils".get_buffer_git_relative_folder()

  -- Create the target folder if it does not exist
  if not os.rename(target_folder, target_folder) then
    os.execute("mkdir -p " .. target_folder)
  end

  -- Create a symbolic link to the current file
  local command = M.get_symlink_command(opts)
  os.execute(command)
  vim.pretty_print("synced files. command: " .. command)

end

M.get_symlink_command = function(opts)
  local file_path = nvim.nvim_buf_get_name(0)

  -- Get the target folder location
  local target_folder = ((opts and opts.base_folder) or M.opts.base_folder) ..
      require "slf.utils".get_buffer_git_relative_folder()

  -- Construct the target file path
  local target_file = target_folder .. "/" .. vim.fn.fnamemodify(file_path, ":t")

  local ln_flags = ((opts and opts.ln_flags) or M.opts.ln_flags)
  local command = "ln " .. ln_flags .. file_path .. " " .. target_file
  vim.pretty_print("sync command: " .. command)
  return command

end

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end
M.setup()

return M

