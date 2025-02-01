return {
  --  {
  --    "neovim/nvim-lspconfig",
  --    ---@class PluginLspOpts
  --    opts = function(_, opts)
  --      opts.autoformat = false
  --    end,
  --  },
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
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "hcl",
        "terraform",
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },
  -- {
  --   "ldelossa/litee.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     notify = { enabled = false },
  --     panel = {
  --       orientation = "bottom",
  --       panel_size = 10,
  --     },
  --   },
  --   config = function(_, opts)
  --     require("litee.lib").setup(opts)
  --   end,
  -- },
  --
  -- {
  --   "ldelossa/litee-calltree.nvim",
  --   dependencies = "ldelossa/litee.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     on_open = "panel",
  --     map_resize_keys = false,
  --   },
  --   config = function(_, opts)
  --     require("litee.calltree").setup(opts)
  --   end,
  -- },
}
