local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then vim.cmd(string.format('%s %s', 'edit', j.path)) end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<CR>'] = select_one_or_multi,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_cursor {
              -- even more opts
            },
          },
          fzf = {
            -- fuzzy = true,
            -- override_generic_sorter = true,
            -- override_file_sorter = true,
            -- case_mode = 'smart_case',
          },
        },
      }
      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'fzf'
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    build = 'make',
  },
  'nvim-telescope/telescope-ui-select.nvim',
}
