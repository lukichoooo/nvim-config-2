return {
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("buffer_manager").setup({
      short_file_names = true,
      short_term_names = true,
      loop_nav = true,
    })
    local bmui = require("buffer_manager.ui")
    local opts = { noremap = true, silent = true }
    -- Toggle buffer menu
    vim.keymap.set("n", "<A-h>", bmui.toggle_quick_menu, opts)
  end,
}
