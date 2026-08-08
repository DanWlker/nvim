local M = {}

---@type string[]?
local dialects = nil

--- The dialects `sqruff` supports, queried lazily and memoized.
---
--- Must NOT run at startup: sqruff lives in mason's bin dir, which is only
--- prepended to PATH by mason.setup(). Querying before then always failed and
--- silently pinned every buffer to --dialect=ansi (plus ~10ms of blocking
--- startup for a spawn that errored).
---@return string[]
local function get_dialects()
  if dialects then return dialects end

  local result = vim.system({ 'sqruff', 'dialects' }, { text = true }):wait()
  dialects = result.code == 0
      and vim.split(result.stdout, '\n', { trimempty = true })
    or {}
  return dialects
end

--- Maps a filetype like `postgres.sql` onto a `--dialect=` argument, falling
--- back to ansi when the dialect is absent or unsupported.
---@param buf integer
---@return string
function M.dialect_arg(buf)
  local dialect = vim.bo[buf].filetype:match('^([^.]+)%.')
  if dialect and vim.tbl_contains(get_dialects(), dialect) then
    return '--dialect=' .. dialect
  end
  return '--dialect=ansi'
end

return M
