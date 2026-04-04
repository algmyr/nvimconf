local M = {}

local function extract(t, key)
  -- Extract the value from the table, and remove it from the table.
  if key == nil then
    local res = t[1]
    table.remove(t, 1)
    return res
  end
  local res = t[key]
  t[key] = nil
  return res
end

local function assert_empty(t)
  for i, _v in ipairs(t) do
    error(string.format('Unexpected value at index %d', i))
  end
  for k, _v in pairs(t) do
    error(string.format('Unexpected field "%s"', k))
  end
end

---@class Extra
---@field init function|nil
---@field config function|nil
---@field build string|function|nil
---@field main string|nil
---@field priority number
---@field dependencies string[]
---@field enabled boolean|nil

-- Specialization of `vim.pack.Spec`.
---@class PluginSpec : vim.pack.Spec
---@field src string,
---@field name string?,
---@field version (string|vim.VersionRange)?,
---@field data Extra

local function handle_plugin_spec(spec, plugin_cb, dev_path)
  if type(spec) == 'string' then spec = { spec } end

  -- Validate field existence.
  ---@type Extra
  local data = {
    priority = 0,
    dependencies = {},
  }

  -- Spec source
  local name = extract(spec, nil)
  -- local dir = extract(spec, 'dir')
  local url = extract(spec, 'url')
  local custom_name = extract(spec, 'name')
  local dev = extract(spec, 'dev')

  local final_src = url
  local final_name = name:match '[^/]+$'
  if not final_src then
    if dev then
      final_src = dev_path .. '/' .. final_name
    else
      final_src = 'https://github.com/' .. name
    end
  end
  if custom_name then
    -- Leave nil to let vim.pack infer.
    final_name = custom_name
  end

  -- Spec loading
  local enabled = extract(spec, 'enabled')
  local cond = extract(spec, 'cond')
  local final_enabled = enabled ~= false and (cond == nil or cond())

  local dependencies = extract(spec, 'dependencies')
  local _plugin_cb = function(p)
    if p.name == nil then error 'Plugin name is required for dependency' end
    table.insert(data.dependencies, p.name)
    plugin_cb(p)
  end
  for _, dep in ipairs(dependencies or {}) do
    handle_plugin_spec(dep, _plugin_cb, dev_path)
  end

  local priority = extract(spec, 'priority')
  data.priority = priority or 0

  -- Spec setup
  data.init = extract(spec, 'init')
  local opts = extract(spec, 'opts')
  local config = extract(spec, 'config')
  if opts and config then error 'Cannot specify both "opts" and "config"' end
  if opts or config then
    data.config = config
      or function(p)
        local main = p.data.main or p.name
        local main_clean = main:gsub('%.nvim$', ''):gsub('%.lua$', '')
        local options = { main_clean, main_clean:gsub('^nvim%-', '') }

        -- Such hackery.
        local setup = nil
        for _, option in ipairs(options) do
          local ok, mod = pcall(require, option)
          if ok and type(mod) == 'table' and type(mod.setup) == 'function' then
            setup = mod.setup
            break
          end
        end
        if setup ~= nil then setup(opts or {}) end
      end
  end
  data.main = extract(spec, 'main')
  data.build = extract(spec, 'build')

  -- Spec lazy loading
  -- All of these are ignored for now
  local _lazy = extract(spec, 'lazy')
  local _event = extract(spec, 'event')
  local _cmd = extract(spec, 'cmd')
  local _ft = extract(spec, 'ft')
  -- local keys = extract(spec, 'keys')

  -- Spec versioning
  local branch = extract(spec, 'branch')
  local tag = extract(spec, 'tag')
  local commit = extract(spec, 'commit')
  local version = extract(spec, 'version')
  if version then version = vim.version.range(version) end
  -- local pin = extract(spec, 'pin')
  -- local submodules = extract(spec, 'submodules')

  local function _int(x)
    if x == nil then return 0 end
    return 1
  end
  local n_set = _int(branch) + _int(tag) + _int(commit) + _int(version)
  assert(n_set <= 1, 'Cannot specify multiple version fields')
  local final_version = branch or tag or commit or version

  plugin_cb {
    src = final_src,
    name = final_name,
    version = final_version,
    data = data,
    enabled = final_enabled,
  }
  -- Assert that all fields have been considered.
  assert_empty(spec)
end

--- Topologically sort plugins, taking into account dependencies and priorities.
---@param plugins table<string, PluginSpec>
---@return string[] order list of plugin names.
local function toposort(plugins)
  local sorted = {}
  local visited = {}
  local function visit(name)
    if visited[name] == 'wip' then error('Cyclic dependency detected: ' .. name) end
    if not visited[name] then
      visited[name] = 'wip'
      local plugin = plugins[name]
      if not plugin then error('Plugin not found: ' .. name) end
      for _, dep in ipairs(plugin.data.dependencies) do
        visit(dep)
      end
      visited[name] = 'done'
      table.insert(sorted, plugin.name)
    end
  end

  local prio_order = {}
  for name, plugin in pairs(plugins) do
    assert(name == plugin.name, 'Plugin name mismatch: ' .. name .. ' vs ' .. tostring(plugin.name))
    table.insert(prio_order, plugin)
  end
  table.sort(prio_order, function(a, b) return a.data.priority > b.data.priority end)

  for _, plugin in ipairs(prio_order) do
    visit(plugin.name)
  end

  return sorted
end

---@param plugin_dirs string[]
---@param dev_path string|nil
---@return table<string, PluginSpec> plugins, string[] order
function M.process_plugins(plugin_dirs, dev_path)
  local all_plugin_files = {}
  for _, dir in ipairs(plugin_dirs) do
    local plugin_files = vim.fn.globpath(vim.fn.stdpath 'config' .. '/lua/' .. dir, '*.lua', true, true)
    for _, file in ipairs(plugin_files) do
      table.insert(all_plugin_files, file)
    end
  end

  -- Require all plugin files and merge into one big list.
  local all_plugins = {}
  for _, file in ipairs(all_plugin_files) do
    local plugins = dofile(file)
    for _, plugin in ipairs(plugins) do
      table.insert(all_plugins, plugin)
    end
  end

  local plugins = {}
  function add_plugin(plugin)
    local cur = plugins[plugin.name]
    if not cur then
      plugins[plugin.name] = plugin
      return
    end
    -- Merge with existing.
    plugins[plugin.name] = vim.tbl_deep_extend(function(key, old, new)
      if not old and new then
        return old or new
      end
      if type(old) == 'table' and type(new) == 'table' then
        if #old == 0 then return new end
        return old
      end
      if key == 'priority' then
        if old > new then
          return old
        else
          return new
        end
      end
      return new
    end, cur, plugin)
  end
  for _, plugin in ipairs(vim.deepcopy(all_plugins)) do
    handle_plugin_spec(plugin, add_plugin, dev_path)
  end

  local filtered = vim
    .iter(plugins)
    :filter(function(_, plugin) return plugin.enabled end)
    :fold({}, function(acc, name, plugin)
      acc[name] = plugin
      return acc
    end)
  return filtered, toposort(filtered)
end

---@param ev any
---@param plugin PluginSpec
local function maybe_build(ev, plugin)
  if plugin.data.build then
    local path = ev.data.path
    local name = plugin.name
    local build = plugin.data.build
    if type(build) == 'string' then
      if build:sub(1, 1) == ':' then
        -- Vim cmd.
        local cmd = vim.api.nvim_parse_cmd(build:sub(2), {}) --[[@as vim.api.keyset.cmd]]
        print(vim.api.nvim_cmd(cmd, { output = true }))
      else
        -- Shell cmd.
        print('Running build command for ' .. name .. ': ' .. build)
        print('In directory: ' .. path)
        local result = vim
          .system({ 'bash', '-c', build }, {
            cwd = path,
          })
          :wait()
        if result.code ~= 0 then error('Build command failed for ' .. name .. ': ' .. result.stderr) end
      end
    else
      -- Assume it's a function.
      build(ev)
    end
  end
end

---@param plugin_dirs string[]
---@param dev_path string|nil
function M.load_plugins_from_dirs(plugin_dirs, dev_path)
  local plugin_specs, topo_order = M.process_plugins(plugin_dirs, dev_path)

  -- Run initializtion.
  for _, plugin in pairs(plugin_specs) do
    if plugin.data.init then plugin.data.init(plugin) end
  end

  -- Register build command on plugin changes.
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local kind = ev.data.kind
      local name = ev.data.spec.name
      if kind == 'update' or kind == 'install' then
        local plugin = plugin_specs[name]
        ---@diagnostic disable-next-line: unnecessary-if
        if plugin then maybe_build(ev, plugin) end
      end
    end,
  })

  -- Add plugins.
  vim.pack.add(vim.tbl_values(plugin_specs))

  -- Configure plugins, note that this is done in toposort order.
  for _, name in ipairs(topo_order) do
    -- Not quite correct, but good enough.
    local plugin = plugin_specs[name]
    if plugin.data.config then plugin.data.config(plugin, {}) end
  end
end

return M
