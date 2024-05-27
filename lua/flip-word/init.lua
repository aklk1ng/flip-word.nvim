local M = {}
local fn, api = vim.fn, vim.api

M.opts = {
  table = {
    ['true'] = 'false',
    ['True'] = 'False',
    ['TRUE'] = 'FALSE',
    ['yes'] = 'no',
    ['Yes'] = 'No',
    ['YES'] = 'NO',
    ['min'] = 'max',
    ['Min'] = 'Max',
    ['MIN'] = 'MAX',
    ['and'] = 'or',
    ['And'] = 'Or',
    ['AND'] = 'OR',
    ['off'] = 'on',
    ['Off'] = 'On',
    ['OFF'] = 'ON',
    ['<'] = '>',
    ['+'] = '-',
    ['+='] = '-=',
    ['=='] = '!=',
    ['<='] = '>=',
    ['<<'] = '>>',
    ['<<='] = '>>=',
    ['->'] = '<-',
    ['&&'] = '||',
    ['&'] = '|',
    ['&='] = '|=',
  },
  key = 'ta',
}

-- just stolen from the `vim` module
local function tbl_keys(t)
  local keys = {}
  for k in pairs(t) do
    if type(k) == 'string' then
      table.insert(keys, k)
    end
  end
  return keys
end

local function reverse(t)
  local keys = tbl_keys(t)
  if not keys then
    return nil
  end
  for _, k in ipairs(keys) do
    local v = t[k]
    if t[v] then
      vim.notify('The table found an existing value')
    end
    t[v] = k
  end
  return t
end

function M.toggle()
  local cur = api.nvim_win_get_cursor(0)
  vim.cmd('normal! viw')
  local s_l, s_r = fn.getpos('v')[2], fn.getpos('v')[3]
  local e_l, e_r = fn.getpos('.')[2], fn.getpos('.')[3]
  local old_word = fn.getline(s_l, e_l)[1]:sub(s_r, e_r)
  api.nvim_feedkeys(api.nvim_replace_termcodes('<Esc>', true, true, true), 'v', true)

  local new_word = M.opts.table[old_word]
  if not new_word then
    vim.notify('Unsupported word', vim.log.levels.INFO)
    api.nvim_win_set_cursor(0, cur)
    return
  end
  api.nvim_buf_set_text(0, s_l - 1, s_r - 1, e_l - 1, e_r, { new_word })
  api.nvim_win_set_cursor(0, cur)
end

function M.setup(opt)
  M.opts = vim.tbl_extend('force', M.opts, opt or {})
  M.opts.table = reverse(M.opts.table)
  if not M.opts.table then
    return
  end
  vim.keymap.set('n', M.opts.key, function()
    M.toggle()
  end)
end

return M
