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
