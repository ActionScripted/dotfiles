--[[
-- Finder: search for files, buffers, git files, etc.
-- ---
-- There are a ton of "pickers" that can be used with Telescope!
-- https://github.com/nvim-telescope/telescope.nvim#pickers
]]
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            -- Disable ctrl+u so default clear is used
            ["<C-u>"] = false,
          },
        },
      },
    },
    keys = {
      -- Informational
      { "<leader>f", desc = "Find / Search" },
      { "<leader>fg", desc = "Find / Search (Git)" },
      -- Files
      { "<c-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Search files" },
      -- Git
      { "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "Find git branches" },
      { "<leader>fgc", "<cmd>Telescope git_commits<cr>", desc = "Find git commits" },
      { "<leader>fgf", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
      { "<leader>fgs", "<cmd>Telescope git_status<cr>", desc = "Find git statuses" },
      --{ '<leader>fb', desc = 'Find buffers' },
      --{ '<leader>fh', desc = 'Find help tags' },
      --{ '<leader>fl', desc = 'Find live grep' },
      --{ '<leader>fs', desc = 'Find grep string' },
      --{ '<leader>fm', desc = 'Find marks' },
      --{ '<leader>fo', desc = 'Find vim options' },
      --{ '<leader>fq', desc = 'Find quickfix' },
      --{ '<leader>fr', desc = 'Find registers' },
      --{ '<leader>ft', desc = 'Find tags' },
      --{ '<leader>fw', desc = 'Find word' },
      --{ '<leader>fy', desc = 'Find vim command history' },
      --{ '<leader>fd', desc = 'Find dotfiles' },
      --{ '<leader>fc', desc = 'Find colorschemes' },
      --{ '<leader>fp', desc = 'Find plugins' },
      --{ '<leader>fe', desc = 'Find emoji' },
      --{ '<leader>fn', desc = 'Find neovim config' },
      --{ '<leader>fv', desc = 'Find vim config' },
      --{ '<leader>fk', desc = 'Find keymaps' },
      --{ '<leader>fq', desc = 'Find quickfix' },
      --{ '<leader>fr', desc = 'Find registers' },
      --{ '<leader>ft', desc = 'Find tags' },
      --{ '<leader>fw', desc = 'Find word' },
      --{ '<leader>fy', desc = 'Find vim command history' },
      --{ '<leader>fd', desc = 'Find dotfiles' },
      --{ '<leader>fc', desc = 'Find colorschemes' },
      --{ '<leader>fp', desc = 'Find plugins' },
      --{ '<leader>fe', desc = 'Find emoji' },
      --{ '<leader>fn', desc = 'Find neovim config' },
      --{ '<leader>fv', desc = 'Find vim config' },
      --{ '<leader>fk', desc = 'Find keymaps' },
      --{ '<leader>fq', desc = 'Find quickfix' }
    },
  },
}
