-- Guard here rather than in lang.toml: ftplugin runs per buffer, so this still
-- fires for a Cargo.toml opened after some other .toml. The require itself is
-- module-cached, so crates.setup() only ever runs once.
-- NOTE: not 'lang.cargo.toml' -- require maps dots onto directory separators,
-- so a file named cargo.toml.lua can never be reached.
if vim.fn.expand('%:t') == 'Cargo.toml' then require('lang.cargo_toml') end
