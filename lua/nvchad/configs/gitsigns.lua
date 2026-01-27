dofile(vim.g.base46_cache .. "git")

return {
  signs = {
    delete = { text = "󰍵" },
    changedelete = { text = "󱕖" },
  },
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
}
