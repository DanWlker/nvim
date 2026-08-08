-- Guard here rather than in lang.toml: ftplugin runs per buffer, so this still
-- fires for a Cargo.toml opened after some other .toml. The require itself is
-- module-cached, so crates.setup() only ever runs once.
if vim.fn.expand('%:t') == 'Cargo.toml' then require('lang.cargo.toml') end
