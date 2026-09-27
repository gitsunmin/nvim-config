-- 기본 옵션

-- leader 키는 플러그인/키맵보다 먼저 설정되어야 함
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

-- Neovim이 터미널의 창/탭 제목(Title)을 변경할 수 있도록 권한을 켬
vim.opt.title = true
vim.opt.titlestring = "📂 %{fnamemodify(getcwd(), ':t')} [%t]"

-- 한글 입력 상태에서도 노멀 모드 명령이 동작하도록 매핑
vim.opt.langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"

-- true color 지원 (bufferline, gitsigns 등 색상 표시에 필요)
vim.opt.termguicolors = true

-- 시스템 클립보드와 자동 공유 (별도 "+ 접두사 없이 y/p 사용 가능)
vim.opt.clipboard = "unnamedplus"

-- 모든 모드에서 마우스 사용 (클릭 이동, 스크롤, 창 크기 조절 등)
vim.opt.mouse = "a"

-- 검색
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 들여쓰기: 스페이스 2칸
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- 종료 후에도 undo 히스토리 유지
vim.opt.undofile = true
