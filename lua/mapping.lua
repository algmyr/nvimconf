function map(mode, lhs, rhs, desc, opts)
  local options = { noremap = true, silent = true, desc = desc }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

function nmap(lhs, rhs, desc, opts) map('n', lhs, rhs, desc, opts) end

function vmap(lhs, rhs, desc, opts) map('v', lhs, rhs, desc, opts) end

function xmap(lhs, rhs, desc, opts) map('x', lhs, rhs, desc, opts) end

function smap(lhs, rhs, desc, opts) map('s', lhs, rhs, desc, opts) end

function imap(lhs, rhs, desc, opts) map('i', lhs, rhs, desc, opts) end

function user_command(name, fun, opts)
  -- preview is a thing, interesting
  vim.api.nvim_create_user_command(name, fun, opts or {})
end

local M = {}

-----------------------------------------------------

-- Convenience functions for creating single model mappings.
M.normal = function(t) return { normal = t } end

M.visual = function(t) return { visual = t } end

M.select = function(t) return { select = t } end

M.insert = function(t) return { insert = t } end

M.operator = function(t) return { operator = t } end

local groupify = function(t, group)
  if t[2] and group then t[2] = t[2] .. ' (' .. group .. ')' end
  return t
end

local function make_map(t, key, binding, group)
  if t[key] then
    local mode = string.sub(key, 1, 1)
    map(mode, binding, unpack(groupify(t[key], group)))
    t[key] = nil
  end
end

M.mappings = function(group)
  return function(binding_table)
    local function dfs(binding, t)
      make_map(t, 'normal', binding, group)
      make_map(t, 'visual', binding, group)
      make_map(t, 'select', binding, group)
      make_map(t, 'insert', binding, group)
      make_map(t, 'operator', binding, group)
      for k, v in pairs(t) do
        dfs(binding .. k, v)
      end
    end
    dfs('', binding_table)
  end
end

return M
