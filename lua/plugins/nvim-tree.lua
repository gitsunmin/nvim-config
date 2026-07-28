-- 파일 탐색기
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({})

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "파일 탐색기 토글" })

    vim.keymap.set("n", "<leader>n", function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "NvimTree" then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end, { desc = "NvimTree 창으로 포커스 이동" })
  end,
}
