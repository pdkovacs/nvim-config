return {
  {
    "crusj/hierarchy-tree-go.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("hierarchy-tree-go").setup()
    end,
  },
}
