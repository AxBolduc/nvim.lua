require('neotest').setup({
  disovery = {
    enabled = false
  },
  adapters = {
    require('neotest-jest')({
      jestCommand = "yarn jest",
      jestConfigFile = function ()
        local file = vim.fn.expand('%:p')

        if string.find(file, "e2e[-]spec.ts") then
          return vim.fn.getcwd() .. "/test/jest-e2e.js"
        end

        return vim.fn.getcwd() .. "/jest.config.ts"
      end,
      jest_test_discovery = false,
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
})

