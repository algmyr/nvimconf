function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
      options = vim.tbl_extend("force", options, opts)
  end
  --print(mode, lhs, rhs, vim.inspect(options))
  vim.keymap.set(mode, lhs, rhs, options)
  --vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function nmap(lhs, rhs, opts)
  map("n", lhs, rhs, opts)
end

function vmap(lhs, rhs, opts)
  map("v", lhs, rhs, opts)
end

function xmap(lhs, rhs, opts)
  map("x", lhs, rhs, opts)
end

function smap(lhs, rhs, opts)
  map("s", lhs, rhs, opts)
end

function imap(lhs, rhs, opts)
  map("i", lhs, rhs, opts)
end
