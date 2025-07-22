return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      },
      formatters = {
        eslint_d = {
          command = "eslint_d",
          args = {
            "--stdin",
            "--fix-to-stdout",
            "--stdin-filename",
            "$FILENAME",
          },
          stdin = true,
        },
      },
      format_on_save = {
        lsp_fallback = false,
        timeout_ms = 1000,
      },
    },
  },
}
