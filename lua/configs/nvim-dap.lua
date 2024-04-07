local utils = require "dap-vscode-js.utils"
local dap = require "dap"

require("dap-vscode-js").setup {
  node_path = "node",
  debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
}
--
-- require("dap").adapters["pwa-node"] = {
--   type = "server",
--   host = "localhost",
--   port = "8123",
--   executable = {
--     command = utils.get_runtime_dir() .. "/mason/packages/js-debug-adapter/js-debug-adapter",
--     args = { "8123" },
--   },
-- }

local exts = {
  "javascript",
  "typescript",
}

for i, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program (pwa-node)",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      resolveSourceMapLocations = {
        "**",
        "${workspaceFolder}/**",
        "${workspaceFolder}/dist/**",
        "**/dist/**",
        "!**/.yarn/cache/**",
        "!./yarm/cacje/**",
      },
      skipFiles = { "<node_internals>/**", "${workspaceFolder}/.yarn/cache/**" },
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node)",
      cwd = vim.fn.getcwd(),
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with ts-node)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "--loader", "ts-node/esm" },
      runtimeExecutable = "node",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with jest)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
      runtimeExecutable = "node",
      args = { "${file}", "--coverage", "false" },
      rootPath = "${workspaceFolder}",
      sourceMaps = true,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with vitest)",
      cwd = vim.fn.getcwd(),
      program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
      args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
      autoAttachChildProcesses = true,
      smartStep = true,
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-chrome",
      request = "attach",
      name = "Attach Program (pwa-chrome = { port: 9222 })",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }
end
