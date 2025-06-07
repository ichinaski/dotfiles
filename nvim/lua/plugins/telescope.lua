return {
  "nvim-telescope/telescope.nvim",
  --branch = "0.1.x",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        }
      },
    })

    function telescope_marks()
      opts = {}
      require("telescope.builtin").marks(opts)
    end

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fh', builtin.help_tags)
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references)
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols)
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
    vim.keymap.set('n', '<leader>fb', builtin.buffers)

    vim.keymap.set("n", "<leader>fm", function()
      builtin.marks { mark_type = "local" }
    end)


  end,
}
