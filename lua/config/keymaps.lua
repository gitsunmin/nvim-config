-- 플러그인에 종속되지 않는 전역 키맵

-- jj로 모드 전환
vim.keymap.set("i", "jj", "<Esc>")

-- 윈도우 간 포커스 이동 (Ctrl+h/j/k/l)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "왼쪽 윈도우로 이동" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "아래 윈도우로 이동" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "위 윈도우로 이동" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "오른쪽 윈도우로 이동" })
