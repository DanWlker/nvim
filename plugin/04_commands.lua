local ncuc = vim.api.nvim_create_user_command

ncuc('CopyRelPath', function() vim.fn.setreg('+', vim.fn.expand('%:.')) end, {
  desc = 'Copy Relative Path',
})

ncuc('CopyAbsPath', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, {
  desc = 'Copy Absolute Path',
})

ncuc('CopyRelPathNoFile', function()
  -- ':h' drops the trailing slash, and yields '.' for a file at the root
  vim.fn.setreg('+', vim.fn.expand('%:.:h') .. '/')
end, {
  desc = 'Copy Relative Path Without File',
})

--- Evaluates a Lua expression, reporting syntax/runtime errors as notifications.
---@param expr string
---@return boolean ok, any result
local function eval(expr)
  -- Wrap the expression in "return ..." so load() evaluates it.
  local chunk, syntax_err = load('return ' .. expr)
  if not chunk then
    vim.notify('Syntax error: ' .. syntax_err, vim.log.levels.ERROR)
    return false, nil
  end

  local ok, result = pcall(chunk)
  if not ok then
    vim.notify('Runtime error: ' .. result, vim.log.levels.ERROR)
    return false, nil
  end

  return true, result
end

ncuc('Print', function(opts)
  local ok, result = eval(opts.fargs[1])
  if ok then print(type(result) == 'table' and vim.inspect(result) or result) end
end, {
  nargs = 1,
  desc = 'Evaluate a Lua expression and print its value',
})

ncuc('CopyTable', function(opts)
  local ok, result = eval(opts.fargs[1])
  if ok then vim.fn.setreg('+', vim.inspect(result)) end
end, {
  nargs = 1,
  desc = 'Evaluate a Lua expression and copy its value',
})
