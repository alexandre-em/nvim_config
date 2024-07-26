return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<C-P>", "<Cmd>Telescope find_files<CR>", desc = "Search for a file" },
    { "<leader>fs", "<Cmd>Telescope live_grep<CR>", desc = "Search on project a keyword with live grep" },
    { "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help tag" },
    { "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
  },
}
