require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "fish", "go", "html", "python", "java" },

  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  }
}
