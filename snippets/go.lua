return {
  s({ trig = 'iferr', name = 'If err != nil snippet' }, {
    t('if '),
    i(1, 'err'),
    t({ ' != nil {', '\treturn ' }),
    i(2, 'err'),
    t({ '\t', '}' }),
  }),
}
