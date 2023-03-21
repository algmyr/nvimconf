return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function ()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor {
              -- even more opts
            }
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  },
  "nvim-telescope/telescope-ui-select.nvim",
}
