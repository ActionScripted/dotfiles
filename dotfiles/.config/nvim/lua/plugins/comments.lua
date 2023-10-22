return {
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        keyword = "bg",
      },
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        FUTURE = { icon = "󰃭 ", color = "hint", alt = { "FUT", "FTR", "NXT", "UPCOMING" } },
        HACK = { icon = " ", color = "warning" },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        PERF = { icon = "󱓟 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        TEST = { icon = "󰔛 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        TODO = { icon = " ", color = "info" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      },
    },
  },
}
