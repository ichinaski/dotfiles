-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>d', toggle_diagnostics, opts)
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lspconfig = require('lspconfig')
local capabilities = lspconfig.util.default_config.capabilities
capabilities = vim.tbl_deep_extend(
  'force',
  capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)
require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
require('lspconfig')['gopls'].setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
