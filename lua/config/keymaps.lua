-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

----------------------- Close buffer
vim.keymap.set("n", "<C-c>", ":q<CR>", { noremap = true, silent = true })

----------------------- Save all Files
-- vim.keymap.set("n", "<C-s>", ":wa<CR>", { noremap = true, silent = true })

----------------------------------------------------- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ff", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

--------------------------------------------------------- Neo-Tree
-- vim.keymap.set("n", "<leader>e", ":Neotree toggle left<CR>", { desc = "Toggle Neo-tree" })

----------------------------------------------------- undo Tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

--------------------------------------------------------- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions, quickfix" })
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "L", vim.diagnostic.open_float, { desc = "Show error under cursor" })

local function toggle_loclist()
  local loclist = vim.fn.getloclist(0, { winid = 0 })
  if loclist.winid ~= 0 then
    vim.cmd("lclose")
  else
    vim.diagnostic.setloclist()

    -- Open loclist and adjust options
    vim.cmd("lopen")
    local win = vim.fn.win_getid()
    vim.api.nvim_win_set_option(win, "wrap", true) -- enable wrapping
    vim.api.nvim_win_set_option(win, "linebreak", true) -- break at word boundaries
    vim.api.nvim_win_set_option(win, "sidescrolloff", 5) -- scroll nicely
  end
end
vim.keymap.set("n", "<leader>q", toggle_loclist)

-- Simple keybinding to restart easy-dotnet LSP
vim.keymap.set("n", "<leader>rd", function()
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == "easy_dotnet" then
      client.stop()
      vim.defer_fn(function()
        vim.cmd("edit") -- reload current buffer
      end, 100)
    end
  end
end, { desc = "Restart easy-dotnet LSP" })

--------------------------------------------------------- Debugger DAP
local dap = require("dap")
local ui = require("dapui")
vim.keymap.set("n", "<F5>", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<F6>", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>du", function()
  ui.toggle()
end, { desc = "Toggle DAP UI" })

--------------------------------------------------------- Format tnone-ls
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Async format" })

------------------------------------------------------- Windsurf / Codeium AI

vim.g.codeium_disable_bindings = 1

-- manual trigger
vim.keymap.set("i", "<A-k>", function()
  return vim.fn["codeium#Complete"]()
end, { expr = true, silent = true })

-- accept full suggestion
vim.keymap.set("i", "<A-h>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

-- next suggestion
vim.keymap.set("i", "<A-l>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })

-- previous suggestion
vim.keymap.set("i", "<A-j>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })

--
local bmui = require("buffer_manager.ui")
local opts = { noremap = true, silent = true }
-- Toggle buffer menu
vim.keymap.set("n", "<A-h>", bmui.toggle_quick_menu, opts)
-- Navigate buffers
vim.keymap.set("n", "<A-j>", bmui.nav_next, opts)
vim.keymap.set("n", "<A-k>", bmui.nav_prev, opts)
