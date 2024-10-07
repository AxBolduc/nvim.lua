local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach()

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ["end"] = { args.line2, end_line:len() },
      }
    end
    require("conform").format { async = true, lsp_format = "fallback", range = range }
  end, { range = true })
end

local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local lspconfig = require "lspconfig"
local servers =
  { "html", "cssls", "ts_ls", "rust_analyzer", "sqlls", "eslint" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- rust_analyzer
lspconfig["rust_analyzer"].setup {
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

-- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   init_options = {
--     hostInfo = "neovim",
--     preferences = {
--       quotePreference = "single",
--       includeCompletionsForModuleExports = true,
--       includeCompletionsForImportStatements = true,
--       includeCompletionsWithSnippetText = true,
--       includeAutomaticOptionalChainCompletions = true,
--       includeCompletionsWithClassMemberSnippets = true,
--       includeCompletionsWithInsertText = true,
--       importModuleSpecifierPreference = "relative",
--       importModuleSpecifierEnding = "minimal",
--       provideRefactorNotApplicableReason = true,
--       allowRenameOfImportPath = true,
--       allowTextChangesInNewFiles = true,
--       displayPartsForJSDoc = true,
--       generateReturnInDocTemplate = true,
--     },
--   },
-- }

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = bufnr,
    --   command = "EslintFixAll",
    -- })
  end,
  on_init = on_init,
  capabilities = capabilities,
}
