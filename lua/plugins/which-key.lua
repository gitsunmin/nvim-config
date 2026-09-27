-- 단축키 치트시트 팝업 (<leader> 등을 누르고 잠시 기다리면 하위 키 목록 표시)
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    -- 팝업이 뜨기까지의 대기 시간 (ms)
    vim.o.timeout = true
    vim.o.timeoutlen = 400
  end,
  opts = {
    preset = "modern",
    spec = {
      { "<leader>a", group = "AI / Claude Code" },
      { "<leader>c", group = "코드 (LSP / 포맷)" },
      { "<leader>f", group = "찾기 (Telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>i", group = "이미지" },
      { "<leader>l", group = "Lazygit" },
      { "<leader>m", group = "마크다운" },
      { "<leader>o", group = "GitHub (Octo)" },
      { "<leader>oi", group = "이슈" },
      { "<leader>op", group = "PR" },
      { "<leader>or", group = "리뷰" },
      { "<leader>ol", group = "라벨" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "버퍼 로컬 키맵 보기",
    },
    {
      "<leader>fk",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "전체 키맵 검색",
    },
  },
}
