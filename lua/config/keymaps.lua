-- 플러그인에 종속되지 않는 전역 키맵

-- jj로 모드 전환
vim.keymap.set("i", "jj", "<Esc>")

-- 윈도우 간 포커스 이동 (Ctrl+h/j/k/l)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "왼쪽 윈도우로 이동" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "아래 윈도우로 이동" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "위 윈도우로 이동" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "오른쪽 윈도우로 이동" })

-- 터미널(Claude Code 등) 안에서도 같은 키로 바로 윈도우 이동 (터미널 모드 탈출 + 이동)
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "왼쪽 윈도우로 이동" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "아래 윈도우로 이동" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "위 윈도우로 이동" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "오른쪽 윈도우로 이동" })
