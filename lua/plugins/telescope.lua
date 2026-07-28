-- Telescope + plenary
return {
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
}
