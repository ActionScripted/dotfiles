--[[
Git: LazyGit integration.
]]
return {
  "kdheepak/lazygit.nvim",
  lazy = false,
  keys = {
    { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}
