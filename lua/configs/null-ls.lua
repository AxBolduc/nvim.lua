local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.prettierd.with({
    condition = function(utils) 
      return utils.has_file({".prettierrc"})
    end,
    filetypes={
      'typescript', 'javascript', 'typescriptreact', 'javascriptreact'
    }
  }),

  -- Lua
  b.formatting.stylua,
  -- cpp
  b.formatting.clang_format,
  -- rust
  b.formatting.rustfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
