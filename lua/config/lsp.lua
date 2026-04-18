local function _collapsing_handler()
  local ns = vim.api.nvim_create_namespace("collapsed_signs")
  local show = vim.diagnostic.handlers.signs.show
  local hide = vim.diagnostic.handlers.signs.hide

  assert(show and hide, "Original signs handler messed up")

  return {
    show = function(_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      local max_severity_per_line = {}
      for _, d in pairs(diagnostics) do
        local m = max_severity_per_line[d.lnum]
        if not m or d.severity < m.severity then
          max_severity_per_line[d.lnum] = d
        end
      end
      local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
      show(ns, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(_, bufnr)
      hide(ns, bufnr)
    end,
  }
end

vim.diagnostic.handlers.signs = _collapsing_handler()
