require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', ';', ':', {desc = "enter command mode",  nowait = true })
map('n', '<leader>fg', "<cmd> Telescope live_grep <CR>", {desc = "live grep"})
map('n', "<leader>'", "<cmd>NvimTreeResize +10 <CR>", {desc = "increate nvimtree width"})
map('n', "<leader>;", "<cmd>NvimTreeResize -10 <CR>", {desc = "decrease nvimtree width"})

-- testing
map('n', "<leader>tt", function()
  local neo = require('neotest')
  neo.output_panel.clear()
  neo.run.run()
end, {desc = "run test"})

map('n', "<leader>td", function()
  local neo = require('neotest')
  neo.output_panel.clear()
  neo.run.run({strategy = 'dap'})
end, {desc = "debug test"})

map('n', "<leader>tt", function()
  local neo = require('neotest')
  neo.output_panel.clear()
  neo.run.run()
end, {desc = "run test"})

map('n', "<leader>to", function()
  local neo = require('neotest')
  neo.output_panel.toggle()
end, {desc = "open test output"})

-- dap
map('n', '<F5>', function() require('dap').continue() end, {desc = "DAP continue"})
map('n', '<F10>', function() require('dap').step_over() end, {desc = "DAP step over"})
map('n', '<F8>', function() require('dap').step_out() end, {desc = "DAP step out"})
map('n', '<F9>', function() require('dap').step_into() end, {desc = "DAP step in"})
map('n', '<leader>bp', function() require('dap').toggle_breakpoint() end, {desc = 'DAP breakpoint'})
map('n', '<leader>du', function()
  local dapui = require('dapui')
  dapui.toggle({reset = true})
end, {desc = 'DAP UI'})

--nvimtree
map('n', '<leader>e', '<cmd>NvimTreeToggle <CR>', {desc = "Toggle NvimTree"})

map('n', '<leader>X', function() require('nvchad.tabufline').closeAllBufs(true) end, {desc = "Close all tabs"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
