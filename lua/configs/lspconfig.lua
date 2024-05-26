-- EXAMPLE
local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach()
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format {
      bufnr = bufnr,
      filter = function(client_format)
        return client_format.name == "null-ls"
      end,
    }
    print "File formatted"
  end, { desc = "Format current buffer with LSP" })
end

local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local lspconfig = require "lspconfig"
local servers =
  { "html", "cssls", "clangd", "tsserver", "rust_analyzer", "sqlls", "astro", "svelte", "eslint", "tailwindcss" }

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
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    hostInfo = "neovim",
    preferences = {
      quotePreference = "single",
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
      includeCompletionsWithSnippetText = true,
      includeAutomaticOptionalChainCompletions = true,
      includeCompletionsWithClassMemberSnippets = true,
      includeCompletionsWithInsertText = true,
      importModuleSpecifierPreference = "relative",
      importModuleSpecifierEnding = "minimal",
      provideRefactorNotApplicableReason = true,
      allowRenameOfImportPath = true,
      allowTextChangesInNewFiles = true,
      displayPartsForJSDoc = true,
      generateReturnInDocTemplate = true,
    },
  },
}
