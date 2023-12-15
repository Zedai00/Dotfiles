return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- {
  --   "Pocco81/auto-save.nvim",
  --   event = "User AstroFile",
  --   config = function() require("auto-save").setup {} end,
  -- },
  {
    "LhKipp/nvim-nu",
    ft = "nu",
    config = function() require("nu").setup {} end,
  },
}
