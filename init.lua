-- ~/.config/nvim/init.lua

-- 기본 옵션
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

-- jj로 모드 전환
vim.keymap.set("i", "jj", "<Esc>")

-- packer 자동 설치
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- packer 설정 시작
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- packer 자체

  -- 파일 탐색기
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("nvim-tree").setup({})
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "파일 탐색기 토글" })
    end
  }

  -- Telescope + plenary
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "파일 찾기" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = "텍스트 검색" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = "버퍼 목록" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = "도움말 검색" })
    end
  }

  -- 최초 설치 후 동기화
  if packer_bootstrap then
    require('packer').sync()
  end
end)
