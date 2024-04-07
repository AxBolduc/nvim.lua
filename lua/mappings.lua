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
map('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, {desc = 'DAP hover'})
map('n', '<leader>dp', function() require('dap.ui.widgets').preview() end, {desc = 'DAP preview'})
map('n', '<leader>df', function()
  local w = require('dap.ui.widgets')
  w.centered_float(w.frames)
end, {desc = 'DAP frames'})
map('n', '<leader>ds', function()
  local w = require('dap.ui.widgets')
  w.centered_float(w.scopes)
end, {desc = 'DAP scopes'})
map('n', '<leader>du', function()
  local dapui = require('dapui')
  dapui.toggle({reset = true})
end, {desc = 'DAP UI'})

--nvimtree
map('n', '<leader>e', '<cmd>NvimTreeToggle <CR>', {desc = "Toggle NvimTree"})

-- completion 
map('i', '<C-Space>', function() vim.lsp.buf.completion() end, {desc = "Get completions"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
