local dap = require "dap"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
		command = "js-debug-adapter",
		args = { "${port}" },
	},
}

local exts = {
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
      -- resolveSourceMapLocations = {
      --   "*",
      --   "**",
      --   "${workspaceFolder}/*",
      --   "${workspaceFolder}/**",
      --   "${workspaceFolder}/dist/**",
      --   "**/dist/**",
      --   "!**/.yarn/cache/**",
      --   "!./yarn/cache/**",
      -- },
      skipFiles = { "<node_internals>/**", "${workspaceFolder}/.yarn/cache/**" },
      -- protocol = "inspector",
      port = '9229'
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
  }
end
