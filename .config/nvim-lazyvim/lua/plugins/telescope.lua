return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<c-p>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files",
    },
  },
}
