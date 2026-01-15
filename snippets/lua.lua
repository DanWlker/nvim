return {
  s({ trig = 'inspect', name = 'Print with Vim Inspect' }, {
    t('print(vim.inspect('),
    i(1, 'message'),
    t('))'),
  }),
  s({ trig = 'con', name = 'Config key for lazy nvim' }, {
    t({ 'config = function()', '\trequire("' }),
    i(1, ''),
    t('").setup'),
    i(2, '()'),
    t({ '', 'end' }),
  }),
}
