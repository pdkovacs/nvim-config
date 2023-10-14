return {
  {
    "folke/noice.nvim",
    enabled = true,
  },
  {
    "ray-x/navigator.lua",
    enabled = false,
    dependencies = {
      { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("navigator").setup()
    end,
  },
  {
    "crusj/hierarchy-tree-go.nvim",
    enabled = false,
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("hierarchy-tree-go").setup()
    end,
  },
}
