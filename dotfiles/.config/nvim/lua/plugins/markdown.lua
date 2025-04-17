--[[
Markdown: tweaks
]]

return {
  {
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    -- https://github.com/iamcco/markdown-preview.nvim/issues/690
    build = function(plugin)
      if vim.fn.executable("npx") then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd([[Lazy load markdown-preview.nvim]])
        vim.fn["mkdp#util#install"]()
      end
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      bullet = {
        enabled = true,
        icons = { "•", "◦", "▪", "⁃" },
      },
      code = {
        right_pad = 2,
        left_pad = 2,
        sign = true,
        width = "full",
      },
      file_types = { "markdown", "norg", "rmd", "org" },
      heading = {
        border = true,
        enabled = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- icons = { "❶ ", "❷ ", "❸ ", "❹ ", "❺ ", "❻ " },
        -- icons = { "⓵ ", "⓶ ", "⓷ ", "⓸ ", "⓹ ", "⓺ " },
        -- icons = { "𝟙 ", "𝟚 ", "𝟛 ", "𝟜 ", "𝟝 ", "𝟞 " },
        sign = true,
      },
    },
  },
}
