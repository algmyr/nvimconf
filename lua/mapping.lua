function map(mode, lhs, rhs, desc, opts)
  local options = { noremap = true, silent = true, desc = desc }
  if opts then
      options = vim.tbl_extend("force", options, opts)
  end
  --print(mode, lhs, rhs, vim.inspect(options))
  vim.keymap.set(mode, lhs, rhs, options)
  --vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function nmap(lhs, rhs, desc, opts)
  map("n", lhs, rhs, desc, opts)
end

function vmap(lhs, rhs, desc, opts)
  map("v", lhs, rhs, desc, opts)
end

function xmap(lhs, rhs, desc, opts)
  map("x", lhs, rhs, desc, opts)
end

function smap(lhs, rhs, desc, opts)
  map("s", lhs, rhs, desc, opts)
end

function imap(lhs, rhs, desc, opts)
  map("i", lhs, rhs, desc, opts)
end

function user_command(name, fun, opts)
  -- preview is a thing, interesting
  vim.api.nvim_create_user_command(name, fun, opts or {})
end
