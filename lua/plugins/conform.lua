-- 포매터
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    },
  },
  init = function()
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      require("conform").format({ lsp_fallback = true })
    end, { desc = "코드 포맷" })
  end,
}
