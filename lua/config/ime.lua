-- Insert 모드에서 <C-;>를 누르면 Normal 모드로 나가면서 입력기를 강제로
-- 영문으로 전환한다. 한글이든 영문이든 현재 상태와 무관하게 항상 영문으로
-- 고정되므로, 이후 `:` 명령이나 leader 키 시퀀스를 바로 입력할 수 있다.
--
-- OS별로 입력기를 전환하는 외부 바이너리가 다르므로, 사용 가능한 백엔드를
-- 감지해 그 백엔드로 위임한다. 해당 바이너리가 설치되어 있지 않으면 Normal
-- 모드로만 나가고 입력기는 건드리지 않는다 (다른 OS로 이 설정을 그대로
-- 옮겨도 에러 없이 동작).
--
--   macOS -> macism         (brew install laishulu/homebrew/macism)
--   Linux -> ibus           (설치되어 있으면 우선 사용)
--   Linux -> fcitx5-remote  (활성/비활성 토글만 가능한 대체 백엔드)

local M = {}

local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

local set_english

if vim.loop.os_uname().sysname == "Darwin" and executable("macism") then
  set_english = function()
    vim.fn.system({ "macism", "com.apple.keylayout.ABC" })
  end
elseif executable("ibus") then
  set_english = function()
    vim.fn.system({ "ibus", "engine", "xkb:us::eng" })
  end
elseif executable("fcitx5-remote") then
  set_english = function()
    vim.fn.system({ "fcitx5-remote", "-c" })
  end
end

vim.keymap.set("i", "<C-;>", function()
  vim.cmd("stopinsert")
  if set_english then
    set_english()
  end
end, { desc = "강제 영문 전환 후 Normal 모드로 이동" })

-- claudeCode 등 :terminal 버퍼는 Insert 모드가 아니라 별도의 Terminal 모드(t)로
-- 동작하므로, 위 Insert 모드 매핑과 별개로 Terminal 모드용 매핑이 필요하다.
vim.keymap.set("t", "<C-;>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  if set_english then
    set_english()
  end
end, { desc = "터미널 모드 탈출 후 강제 영문 전환" })

return M
