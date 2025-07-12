local options = {
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    lua = { "stylua" },
    nix = { "alejandra" },
    python = { "ruff_format" },
    rust = { "rustfmt", lsp_format = "fallback" },
    vala = { lsp_format = "always" },
  },
  format_on_save = true,
  timeout_ms = 500,
}

return options
