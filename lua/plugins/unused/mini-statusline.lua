-- MiniStatuslineDevinfo = { bg = colors.surface0 },
-- MiniStatuslineFileinfo = { bg = colors.surface0 },
-- MiniStatuslineDiagnosticError = { bg = colors.surface0, fg = colors.red },
-- MiniStatuslineDiagnosticWarn = { bg = colors.surface0, fg = colors.yellow },
-- MiniStatuslineDiagnosticInfo = { bg = colors.surface0, fg = colors.sky },
-- MiniStatuslineDiagnosticHint = { bg = colors.surface0, fg = colors.teal },

local icons = require('shared.icons')
local diagnostics_highlight = {
  { name = 'ERROR', hl = 'MiniStatuslineDiagnosticError' },
  { name = 'WARN', hl = 'MiniStatuslineDiagnosticWarn' },
  { name = 'INFO', hl = 'MiniStatuslineDiagnosticInfo' },
  { name = 'HINT', hl = 'MiniStatuslineDiagnosticHint' },
}

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return '  ' .. recording_register
    -- return '󰑊  ' .. recording_register
    -- return '󰑋  ' .. recording_register
  end
end

return {
  'nvim-mini/mini.statusline',
  dependencies = {
    {
      'nvim-mini/mini-git',
      main = 'mini.git',
      config = function()
        require('mini.git').setup({})

        -- Use only HEAD name as summary string
        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniGitUpdated',
          group = vim.api.nvim_create_augroup(
            'danwlker/mini-git-head',
            { clear = true }
          ),
          callback = function(data)
            -- Utilize buffer-local table summary
            local summary = vim.b[data.buf].minigit_summary
            vim.b[data.buf].minigit_summary_string = summary.head_name or ''
          end,
        })
      end,
    },
  },
  config = function()
    local MiniStatusline = require('mini.statusline')

    local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
    local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)
    MiniStatusline.section_mode = function(args)
      local modes = setmetatable({
        ['n'] = {
          long = '(˵•̀ ᴗ -)',
          short = 'N',
          hl = 'MiniStatuslineModeNormal',
        },
        ['v'] = { long = '( -_・)σ', short = 'V', hl = 'MiniStatuslineModeVisual' },
        ['V'] = {
          long = '( -_・)σ',
          short = 'V-L',
          hl = 'MiniStatuslineModeVisual',
        },
        [CTRL_V] = {
          long = '( -_・)σ',
          short = 'V-B',
          hl = 'MiniStatuslineModeVisual',
        },
        ['s'] = {
          long = '(´ ▽｀) ',
          short = 'S',
          hl = 'MiniStatuslineModeVisual',
        },
        ['S'] = {
          long = '(´ ▽｀) ',
          short = 'S-L',
          hl = 'MiniStatuslineModeVisual',
        },
        [CTRL_S] = {
          long = '(´ ▽｀) ',
          short = 'S-B',
          hl = 'MiniStatuslineModeVisual',
        },
        ['i'] = {
          long = '(•̀ - •́ )',
          short = 'I',
          hl = 'MiniStatuslineModeInsert',
        },
        ['R'] = {
          long = '( •̯́ ₃ •̯̀)',
          short = 'R',
          hl = 'MiniStatuslineModeReplace',
        },
        ['c'] = {
          long = 'Σ(°△°ꪱꪱ)',
          short = 'C',
          hl = 'MiniStatuslineModeCommand',
        },
        ['r'] = {
          long = 'Σ(°△°ꪱꪱ)',
          short = 'P',
          hl = 'MiniStatuslineModeOther',
        },
        ['!'] = {
          long = 'Σ(°△°ꪱꪱ)',
          short = 'Sh',
          hl = 'MiniStatuslineModeOther',
        },
        ['t'] = {
          long = ' (⌐■_■) ',
          short = 'T',
          hl = 'MiniStatuslineModeOther',
        },
      }, {
        __index = function()
          return { long = 'Unknown', short = 'U', hl = '%#MiniStatuslineModeOther#' }
        end,
      })
      local mode_info = modes[vim.fn.mode()]
      local mode = MiniStatusline.is_truncated(args.trunc_width) and mode_info.short
        or mode_info.long
      return mode, mode_info.hl
    end

    MiniStatusline.section_location = function() return '%2l:%-2v' end

    MiniStatusline.section_diagnostics = function(args)
      if
        MiniStatusline.is_truncated(args.trunc_width)
        or not vim.diagnostic.is_enabled({ bufnr = 0 })
      then
        return ''
      end

      -- Construct string parts
      local count = vim.diagnostic.count(0)
      local severity, t = vim.diagnostic.severity, {}
      for _, level in ipairs(diagnostics_highlight) do
        local n = count[severity[level.name]] or 0
        -- Add level info only if diagnostic is present
        if n > 0 then
          table.insert(t, ' ' .. '%#' .. level.hl .. '#' .. icons[level.name] .. n)
        end
      end
      if #t == 0 then return '' end

      return table.concat(t, '')
    end

    MiniStatusline.setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ icon = '', trunc_width = 40 })
          local diagnostics =
            MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location()
          local recording = show_macro_recording()

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { '%=' .. filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineRecording', strings = { recording } },
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { location } },
          })
        end,
        inactive = function() return '%=%#MiniStatuslineInactive#%F%=' end,
      },
      use_icons = vim.g.have_nerd_font,
    })
  end,
}
