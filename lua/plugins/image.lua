-- 이미지 미리보기
return {
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      -- [패치] image.nvim 문서 통합의 query_buffer_images 방어 코드
      -- Neovim 0.11+ 에서 vim.treesitter.get_parser 는 에러를 던지지 않고 nil 을 반환한다.
      -- image.nvim 은 nil 검사를 하지 않아서, 아직 로드되지 않은(또는 wipe 중인)
      -- filetype=markdown 버퍼가 창에 걸려 있으면 "attempt to index local 'parser'" 로 죽는다.
      local document = require("image/utils/document")
      local create_document_integration = document.create_document_integration
      document.create_document_integration = function(cfg)
        local query_buffer_images = cfg.query_buffer_images
        cfg.query_buffer_images = function(buffer)
          local buf = buffer or vim.api.nvim_get_current_buf()
          if not vim.api.nvim_buf_is_loaded(buf) then return {} end
          local ok, result = pcall(query_buffer_images, buffer)
          if not ok then return {} end
          return result
        end
        return create_document_integration(cfg)
      end

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
