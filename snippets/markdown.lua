return {
  s({ trig = 'caption', name = 'Insert captions' }, {
    t('<sub>'),
    i(1, 'caption'),
    t('</sub>'),
  }),
  s({ trig = 'checkbox', name = 'Insert checkbox' }, {
    t('- [ ] '),
  }),
}
