-- 버퍼라인
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({})
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "다음 버퍼" })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "이전 버퍼" })
  end,
}
