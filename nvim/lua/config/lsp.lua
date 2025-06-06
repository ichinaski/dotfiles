-- LSP
vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  settings = {
    gopls = {
      buildFlags =  {"-tags=test zlib zstd"}
    }
  },
  root_markers = { 'go.mod', '.git' },
  filetypes = { 'go' },
}

vim.lsp.config.python = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true
      }
    }
  }
}

vim.lsp.enable("gopls")
vim.lsp.enable("python")

-- Completion
-- Use CTRL-space to trigger LSP completion.
vim.keymap.set('i', '<c-space>', function()
  vim.lsp.completion.get()
end)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover) -- default
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename) -- default
    vim.keymap.set('n', 'gca', vim.lsp.buf.code_action) -- default
    vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, bufopts)

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        -- vim.lsp.buf.format {async = false, id = ev.data.client_id }
        vim.lsp.buf.format {async = false }
      end,
    })
  end,
})

-- Diagnostics
function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

vim.diagnostic.config({
  -- virtual_text = true,
  -- severity = { min = vim.diagnostic.severity.WARN },
  float = true,
})
vim.keymap.set('n', '<leader>d', toggle_diagnostics, opts)
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = new_config })
end, { desc = 'Toggle diagnostic virtual_text' })
