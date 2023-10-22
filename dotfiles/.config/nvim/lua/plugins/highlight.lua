--[[
Highlight: show other instances of a word.
]]

return {
  {
    "RRethy/vim-illuminate",
    opts = { delay = 200 },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
