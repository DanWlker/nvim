local ncuc = vim.api.nvim_create_user_command

ncuc('FormatJson', function(opts)
  if opts.range > 0 then
    vim.cmd(opts.line1 .. ',' .. opts.line2 .. '!jq')
  else
    -- No selection: apply to whole buffer
    vim.cmd('%!jq')
  end
end, {
  desc = 'Format Json',
  range = true,
})

ncuc('CopyRelPath', function()
  local path = vim.fn.expand('%:.')
  vim.fn.setreg('+', path)
end, {
  desc = 'Copy Relative Path',
})

ncuc('CopyAbsPath', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
end, {
  desc = 'Copy Absolute Path',
})

ncuc('CopyRelPathNoFile', function()
  local path = vim.fn.expand('%:.')
  local dir = path:match('(.*/)')
  vim.fn.setreg('+', dir)
end, {
  desc = 'Copy Relative Path Without File',
})

ncuc('Reload', function(opts)
  local name = opts.fargs[1]
  package.loaded[name] = nil
  require(name).setup()
end, {
  nargs = 1,
  desc = 'Reload plugin',
})

ncuc('FormatSql', function(opts)
  if opts.range > 0 then
    vim.cmd(opts.line1 .. ',' .. opts.line2 .. '!sleek')
  else
    -- No selection: apply to whole buffer
    vim.cmd('%!sleek')
  end
end, {
  desc = 'Format Sql',
  range = true,
})

ncuc('Print', function(opts)
  local expr = opts.fargs[1]

  -- Wrap the expression in "return ..." so loadstring evaluates it.
  local chunk, syntax_err = loadstring('return ' .. expr)
  if not chunk then
    vim.notify('Syntax error: ' .. syntax_err, vim.log.levels.ERROR)
    return
  end

  local ok, result = pcall(chunk)
  if not ok then
    vim.notify('Runtime error: ' .. result, vim.log.levels.ERROR)
    return
  end

  print(type(result) == 'table' and vim.inspect(result) or result)
end, {
  nargs = 1,
  desc = 'Evaluate a Lua expression and print its value',
})

ncuc('CopyTable', function(opts)
  local expr = opts.fargs[1]

  -- Wrap the expression in "return ..." so loadstring evaluates it.
  local chunk, syntax_err = loadstring('return ' .. expr)
  if not chunk then
    vim.notify('Syntax error: ' .. syntax_err, vim.log.levels.ERROR)
    return
  end

  local ok, result = pcall(chunk)
  if not ok then
    vim.notify('Runtime error: ' .. result, vim.log.levels.ERROR)
    return
  end

  vim.fn.setreg('+', vim.inspect(result))
end, {
  nargs = 1,
  desc = 'Evaluate a Lua expression and print its value',
})
