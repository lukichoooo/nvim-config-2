return {
  "Exafunction/windsurf.vim",
  event = "BufEnter",
  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_manual = false -- change to false for manual autocomplete
    vim.g.codeium_idle_delay = 0
  end,
}
