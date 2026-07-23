-- ~/.config/nvim/init.lua

-- 기본 옵션
vim.opt.number = true
-- 1. Neovim이 터미널의 창/탭 제목(Title)을 변경할 수 있도록 권한을 켭니다.
vim.opt.title = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.opt.titlestring = "📂 %{fnamemodify(getcwd(), ':t')} [%t]"
vim.opt.langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"

-- jj로 모드 전환
vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("n", "<leader>n", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "NvimTree" then
      vim.api.nvim_set_current_win(win)
      break
    end
  end
end, { desc = "NvimTree 창으로 포커스 이동" })

-- lazy.nvim 자동 설치
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 플러그인 설정
require("lazy").setup({
  -- 파일 탐색기
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "파일 탐색기 토글" })
    end,
  },

  -- Telescope + plenary
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "파일 찾기" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "텍스트 검색" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "버퍼 목록" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "도움말 검색" })
    end,
  },

  -- 터미널
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "float",
      })

      -- lazygit 터미널
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        float_opts = {
          border = "curved",
        },
      })
      vim.keymap.set("n", "<leader>lg", function() lazygit:toggle() end, { desc = "Lazygit 열기" })
    end,
  },

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

  -- 이미지 미리보기
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            only_render_image_at_cursor = false,
          },
        },
        max_width = 100,
        max_height = 30,
        max_height_window_percentage = 50,
        max_width_window_percentage = 50,
      })
      vim.keymap.set("n", "<leader>ic", function()
        require("image").clear()
      end, { desc = "이미지 모두 지우기" })
    end,
  },

  -- luarocks (image.nvim 의존성)
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  -- GitHub PR/Issue 관리
  {
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
  },

  -- 버퍼라인
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({})
      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "다음 버퍼" })
      vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "이전 버퍼" })
    end,
  },
})
