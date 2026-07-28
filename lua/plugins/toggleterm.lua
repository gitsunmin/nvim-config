-- 터미널
return {
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
}
