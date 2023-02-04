-- Register the command in your plugin file
vim.api.nvim_create_user_command("SymlinkFile", function()
  require"slf".symlink_file()
end, { nargs = 0 })
-- vim.api.nvim_create_user_command("SummarizeArticle", SummarizeArticle, { nargs = 1})
