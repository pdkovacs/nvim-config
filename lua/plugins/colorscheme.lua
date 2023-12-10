return {
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  { "joshdick/onedark.vim" },
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim" },
  { "sainnhe/edge" },
  { "tanvirtin/monokai.nvim" },
  { "rktjmp/lush.nvim" }, -- Not a colorscheme, gives realtime feedback on colorschemes; required by zenbones
  { "mcchrish/zenbones.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "Mofiqul/dracula.nvim" },
  -- {
  --   "maxmx03/dracula.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     local dracula = require("dracula")
  --
  --     dracula.setup()
  --
  --     vim.cmd.colorscheme("dracula")
  --   end,
  -- },
  -- Configure LazyVim to load <colorscheme>
  {
    "LazyVim/LazyVim",
    opts = {
      --      colorscheme = "monokai",
      install = {
        missing = true,
        colorscheme = "nightfox",
      },
    },
  },
}
