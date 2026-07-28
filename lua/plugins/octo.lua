-- GitHub PR/Issue 관리
return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("octo").setup({
      suppress_missing_scope = {
        projects_v2 = true,
      },
    })
    vim.keymap.set("n", "<leader>oil", ":Octo issue list<CR>", { desc = "이슈 목록 보기" })
    vim.keymap.set("n", "<leader>oic", ":Octo issue create<CR>", { desc = "이슈 생성" })
    vim.keymap.set("n", "<leader>opl", ":Octo pr list<CR>", { desc = "PR 목록 보기" })
    vim.keymap.set("n", "<leader>opc", ":Octo pr create<CR>", { desc = "PR 생성" })
    vim.keymap.set("n", "<leader>opd", ":Octo pr diff<CR>", { desc = "PR diff 보기" })
    vim.keymap.set("n", "<leader>opm", ":Octo pr merge<CR>", { desc = "PR 병합" })
    vim.keymap.set("n", "<leader>oca", ":Octo comment add<CR>", { desc = "코멘트 추가" })
    vim.keymap.set("n", "<leader>ora", ":Octo review start<CR>", { desc = "리뷰 시작" })
    vim.keymap.set("n", "<leader>ors", ":Octo review submit<CR>", { desc = "리뷰 제출" })
    vim.keymap.set("n", "<leader>olb", ":Octo label add<CR>", { desc = "라벨 추가" })
    vim.keymap.set("n", "<leader>oas", ":Octo assignee add<CR>", { desc = "담당자 추가" })
  end,
}
