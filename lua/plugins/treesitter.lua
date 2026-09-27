-- Treesitter (nvim-treesitter main 브랜치)
--
-- main 브랜치는 master 와 완전히 다른 재작성 버전이다.
--   - 파서 자동 설치를 하지 않는다 → install() 로 명시해야 한다
--   - 하이라이트/폴드/들여쓰기를 자동으로 켜지 않는다 → 직접 켜야 한다
--   - lazy 로딩을 지원하지 않는다 → lazy = false
--   - 파서 컴파일에 tree-sitter CLI(0.26.1+)와 C 컴파일러가 필요하다
--     (brew install tree-sitter-cli)
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      -- 파서와 쿼리 설치 위치 (runtimepath 앞에 추가되어 내장 파서보다 우선함)
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- 설치할 파서 목록. 이미 설치돼 있으면 아무 일도 하지 않는다.
    -- 추가하려면 :TSInstall <lang> 또는 아래 목록에 넣고 재시작.
    ts.install({
      -- nvim 설정
      "lua", "luadoc", "vim", "vimdoc", "query",
      -- 문서 (image.nvim / obsidian / mdx)
      "markdown", "markdown_inline",
      -- 웹
      "typescript", "tsx", "javascript", "jsdoc", "html", "css",
      -- 데이터/설정
      -- jsonc 는 별도 파서가 없고 json 파서를 사용한다
      "json", "yaml", "toml",
      -- 기타
      "bash", "python",
      -- git (octo / gitsigns / diffview)
      "diff", "gitcommit", "git_rebase", "git_config",
    })

    -- 하이라이트 활성화.
    -- 파서가 없는 filetype 에서는 vim.treesitter.start 가 실패하므로 pcall 로 감싼다.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter.highlight", { clear = true }),
      callback = function(args)
        -- 아주 큰 파일은 treesitter 를 건너뛰고 기본 syntax 를 쓴다
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > 1024 * 1024 then return end

        pcall(vim.treesitter.start, args.buf)

        -- treesitter 기반 폴드 (필요하면 주석 해제)
        -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- vim.wo[0][0].foldmethod = "expr"
      end,
    })
  end,
}
