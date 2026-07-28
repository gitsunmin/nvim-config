-- 이미지 미리보기
return {
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
}
