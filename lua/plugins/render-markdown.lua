-- 마크다운 인라인 렌더링 (헤딩, 코드 블록, 표, 체크박스, 콜아웃 등을 버퍼 안에서 꾸며서 보여줌)
--
-- - Normal 모드에서만 렌더링하고, Insert 모드에 들어가면 원문이 그대로 보인다
-- - 커서가 있는 줄은 원문을 보여준다 (anti_conceal)
-- - 이미지는 image.nvim 이 담당한다 (lua/plugins/image.lua)
local ft = { "markdown", "mdx" }

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = ft,
  opts = {
    file_types = ft,
    -- 체크박스(`- [`) / 콜아웃(`> [!`) 입력 시 nvim-cmp 의 nvim_lsp 소스로 자동완성 제공
    completions = { lsp = { enabled = true } },
  },
  keys = {
    { "<leader>mm", "<cmd>RenderMarkdown buf_toggle<cr>", ft = ft, desc = "렌더링 토글 (현재 버퍼)" },
    { "<leader>mM", "<cmd>RenderMarkdown toggle<cr>", ft = ft, desc = "렌더링 토글 (전역)" },
    { "<leader>mp", "<cmd>RenderMarkdown preview<cr>", ft = ft, desc = "옆 창에 미리보기" },
    { "<leader>me", "<cmd>RenderMarkdown expand<cr>", ft = ft, desc = "원문 표시 범위 넓히기" },
    { "<leader>mc", "<cmd>RenderMarkdown contract<cr>", ft = ft, desc = "원문 표시 범위 좁히기" },
  },
}
