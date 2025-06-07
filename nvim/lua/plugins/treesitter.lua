return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "lua", "fish", "go", "html", "python", "java", "vim", "vimdoc", "rust" },
      highlight = { enable = true, },
      indent = { enable = false, },
    })
  end
}
