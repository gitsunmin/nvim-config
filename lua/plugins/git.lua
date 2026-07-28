-- Git 관련 플러그인
return {
  -- Git 표시
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({})
      vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "다음 변경 사항" })
      vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "이전 변경 사항" })
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "변경 사항 미리보기" })
      vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "변경 사항 스테이지" })
      vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "스테이지 취소" })
      vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "변경 사항 되돌리기" })
      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "현재 줄 blame 보기" })
    end,
  },

  -- Git 그래프
  {
    "isakbm/gitgraph.nvim",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {
      symbols = {
        merge_commit = "M",
        commit = "*",
      },
      format = {
        timestamp = "%Y-%m-%d %H:%M:%S",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>gl", function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end, { desc = "Git 그래프 보기" })
    end,
  },
}
