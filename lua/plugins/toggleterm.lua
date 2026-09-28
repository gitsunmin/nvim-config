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
        -- difftastic side-by-side diff가 잘리지 않도록 화면을 넓게 쓴다
        width = function() return math.floor(vim.o.columns * 0.95) end,
        height = function() return math.floor(vim.o.lines * 0.9) end,
      },
    })
    vim.keymap.set("n", "<leader>lg", function() lazygit:toggle() end, { desc = "Lazygit 열기" })
  end,
}
