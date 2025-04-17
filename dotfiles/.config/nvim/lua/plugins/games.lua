--[[
Games: yeah, games.
]]
return {
  {
    "eandrju/cellular-automaton.nvim",
    cmd = { "CellularAutomaton" },
  },
  {
    "alanfortlink/blackjack.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = false,
    opts = {
      card_style = "mini", -- Can be "mini" or "large".
      suit_style = "black", -- Can be "black" or "white".
      scores_path = "/home/foo/blackjack_scores.json", -- Default location to store the scores.json file.
      keybindings = {
        ["next"] = "j",
        ["finish"] = "k",
        ["quit"] = "q",
      },
    },
  },
  {
    "alec-gibson/nvim-tetris",
    enabled = false,
  },
  {
    "actionscripted/tetris.nvim",
    -- dir = "~/Projects/tetris.nvim",
    enabled = true,
    cmd = { "Tetris" },
    keys = { { "<leader>T", "<cmd>Tetris<cr>", desc = "Tetris" } },
    opts = {},
  },
}
