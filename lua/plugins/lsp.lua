return {
  --  {
  --    "neovim/nvim-lspconfig",
  --    ---@class PluginLspOpts
  --    opts = function(_, opts)
  --      opts.autoformat = false
  --    end,
  --  },
  {
    "folke/noice.nvim",
    enabled = true,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
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
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "hcl",
        "terraform",
      },
    },
  },
}
