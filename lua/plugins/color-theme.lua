return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- deep dark
        transparent = false,
        styles = {
          comments = { italic = true },
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
