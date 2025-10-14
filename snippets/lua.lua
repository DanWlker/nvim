return {
  s({ trig = 'inspect', name = 'Print with Vim Inspect' }, {
    t('print(vim.inspect('),
    i(1, 'message'),
    t('))'),
  }),
}
