local config = require("kintsugi.config")
local palette = require("kintsugi.palette")
local util = require("kintsugi.util")

local M = {}

local function with_user_style(default, override)
  return vim.tbl_extend("force", default, override or {})
end

local function bg_or_none(opts, color)
  if opts.transparent then
    return "NONE"
  end
  return color
end

local function groups(c, opts)
  local comment_style = opts.styles.comments or {}
  local keyword_style = opts.styles.keywords or {}
  local function_style = opts.styles.functions or {}
  local variable_style = opts.styles.variables or {}

  local bg = bg_or_none(opts, c.bg)
  local bg_alt = bg_or_none(opts, c.bg_alt)
  local bg_float = bg_or_none(opts, c.bg_float)

  return {
    Normal = { fg = c.fg, bg = bg },
    NormalNC = { fg = c.fg, bg = bg },
    NormalFloat = { fg = c.fg, bg = bg_float },
    FloatBorder = { fg = c.border, bg = bg_float },
    FloatTitle = { fg = c.accent, bg = bg_float, bold = true },
    ColorColumn = { bg = c.bg_cursorline },
    Conceal = { fg = c.fg_dim },
    Cursor = { fg = c.bg, bg = c.accent },
    lCursor = { fg = c.bg, bg = c.accent },
    CursorIM = { fg = c.bg, bg = c.accent },
    CursorColumn = { bg = c.bg_cursorline },
    CursorLine = { bg = c.bg_cursorline },
    CursorLineNr = { fg = c.storage, bg = c.bg_cursorline, bold = true },
    LineNr = { fg = c.fg_gutter, bg = bg },
    SignColumn = { fg = c.fg_gutter, bg = bg },
    VertSplit = { fg = c.border },
    WinSeparator = { fg = c.border },
    FoldColumn = { fg = c.fg_dim, bg = bg },
    Folded = { fg = c.fg_dim, bg = c.bg_cursorline },
    EndOfBuffer = { fg = c.bg_alt, bg = bg },
    MatchParen = { fg = c.accent, bg = c.bg_search, bold = true },
    StatusLine = { fg = c.fg_alt, bg = c.bg_alt },
    StatusLineNC = { fg = c.fg_dim, bg = c.bg_alt },
    TabLine = { fg = c.fg_dim, bg = c.bg_alt },
    TabLineFill = { fg = c.fg_dim, bg = c.bg_alt },
    TabLineSel = { fg = c.fg, bg = bg, bold = true },
    Directory = { fg = c.storage },
    Title = { fg = c.storage, bold = true },
    Visual = { bg = c.bg_visual },
    VisualNOS = { bg = c.bg_visual },
    Search = { fg = c.fg, bg = c.bg_search },
    CurSearch = { fg = c.bg, bg = c.accent, bold = true },
    IncSearch = { fg = c.bg, bg = c.accent, bold = true },
    Substitute = { fg = c.bg, bg = c.warn, bold = true },
    Pmenu = { fg = c.fg, bg = bg_float },
    PmenuSel = { fg = c.fg, bg = c.bg_pmenu_sel, bold = true },
    PmenuSbar = { bg = c.bg_alt },
    PmenuThumb = { bg = c.accent },
    Question = { fg = c.info },
    QuickFixLine = { bg = c.bg_cursorline, bold = true },
    Whitespace = { fg = c.border },

    Comment = with_user_style({ fg = c.comment }, comment_style),
    Constant = { fg = c.constant },
    String = { fg = c.string },
    Character = { fg = c.string },
    Number = { fg = c.number },
    Boolean = { fg = c.number },
    Float = { fg = c.number },
    Identifier = with_user_style({ fg = c.fg }, variable_style),
    Function = with_user_style({ fg = c.func }, function_style),
    Statement = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    Conditional = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    Repeat = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    Label = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    Operator = { fg = c.operator },
    Keyword = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    Exception = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    PreProc = { fg = c.preproc, bold = true },
    Include = { fg = c.preproc, bold = true },
    Define = { fg = c.preproc, bold = true },
    Macro = { fg = c.preproc, bold = true },
    PreCondit = { fg = c.preproc, bold = true },
    Type = { fg = c.type },
    StorageClass = { fg = c.storage, bold = true },
    Structure = { fg = c.type },
    Typedef = { fg = c.type },
    Special = { fg = c.punct },
    SpecialChar = { fg = c.punct },
    Tag = { fg = c.tag },
    Delimiter = { fg = c.punct },
    SpecialComment = { fg = c.comment },
    Debug = { fg = c.warn },
    Underlined = { fg = c.link, underline = true },
    Ignore = { fg = c.fg_dim },
    Error = { fg = c.error, bold = true },
    Todo = { fg = c.bg, bg = c.storage, bold = true },

    DiffAdd = { bg = c.bg_diff_add },
    DiffDelete = { bg = c.bg_diff_delete },
    DiffChange = { bg = c.bg_diff_change },
    DiffText = { bg = c.bg_diff_text },

    DiagnosticError = { fg = c.error },
    DiagnosticWarn = { fg = c.warn },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },
    DiagnosticOk = { fg = c.hint },
    DiagnosticUnderlineError = { undercurl = true, sp = c.error },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warn },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },
    DiagnosticSignError = { fg = c.error, bg = bg },
    DiagnosticSignWarn = { fg = c.warn, bg = bg },
    DiagnosticSignInfo = { fg = c.info, bg = bg },
    DiagnosticSignHint = { fg = c.hint, bg = bg },
    DiagnosticVirtualTextError = { fg = c.error, bg = c.bg_alt },
    DiagnosticVirtualTextWarn = { fg = c.warn, bg = c.bg_alt },
    DiagnosticVirtualTextInfo = { fg = c.info, bg = c.bg_alt },
    DiagnosticVirtualTextHint = { fg = c.hint, bg = c.bg_alt },
    LspReferenceText = { bg = c.bg_search },
    LspReferenceRead = { bg = c.bg_search },
    LspReferenceWrite = { bg = c.bg_search },

    GitSignsAdd = { fg = c.hint, bg = bg },
    GitSignsChange = { fg = c.warn, bg = bg },
    GitSignsDelete = { fg = c.error, bg = bg },
    GitSignsCurrentLineBlame = { fg = c.fg_dim, italic = true },

    ["@annotation"] = { fg = c.annotation },
    ["@attribute"] = { fg = c.annotation },
    ["@attribute.builtin"] = { fg = c.support or c.annotation },
    ["@boolean"] = { fg = c.number },
    ["@character"] = { fg = c.string },
    ["@character.special"] = { fg = c.type },
    ["@comment"] = with_user_style({ fg = c.comment }, comment_style),
    ["@comment.error"] = { fg = c.error },
    ["@comment.warning"] = { fg = c.warn },
    ["@comment.todo"] = { fg = c.storage, bold = true },
    ["@constant"] = { fg = c.constant },
    ["@constant.builtin"] = { fg = c.constant, bold = true },
    ["@constant.macro"] = { fg = c.preproc, bold = true },
    ["@constructor"] = { fg = c.type },
    ["@diff.plus"] = { fg = c.hint },
    ["@diff.minus"] = { fg = c.error },
    ["@diff.delta"] = { fg = c.warn },
    ["@function"] = with_user_style({ fg = c.func }, function_style),
    ["@function.builtin"] = { fg = c.support or c.type },
    ["@function.call"] = with_user_style({ fg = c.func }, function_style),
    ["@function.macro"] = { fg = c.preproc, bold = true },
    ["@keyword"] = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    ["@keyword.conditional"] = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    ["@keyword.directive"] = { fg = c.preproc, bold = true },
    ["@keyword.directive.define"] = { fg = c.preproc, bold = true },
    ["@keyword.exception"] = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    ["@keyword.function"] = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    ["@keyword.import"] = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    ["@keyword.modifier"] = with_user_style({ fg = c.storage, bold = true }, keyword_style),
    ["@keyword.operator"] = { fg = c.operator },
    ["@keyword.repeat"] = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    ["@keyword.return"] = with_user_style({ fg = c.keyword, bold = true }, keyword_style),
    ["@keyword.storage"] = with_user_style({ fg = c.storage, bold = true }, keyword_style),
    ["@keyword.type"] = with_user_style({ fg = c.storage, bold = true }, keyword_style),
    ["@label"] = { fg = c.keyword },
    ["@markup.heading"] = { fg = c.storage, bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.list"] = { fg = c.punct },
    ["@markup.link"] = { fg = c.link, underline = true },
    ["@markup.link.url"] = { fg = c.link, underline = true },
    ["@markup.raw"] = { fg = c.string },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.strong"] = { bold = true },
    ["@module"] = { fg = c.type },
    ["@namespace"] = { fg = c.type },
    ["@number"] = { fg = c.number },
    ["@number.float"] = { fg = c.number },
    ["@operator"] = { fg = c.operator },
    ["@property"] = { fg = c.fg },
    ["@punctuation.bracket"] = { fg = c.punct },
    ["@punctuation.delimiter"] = { fg = c.punct },
    ["@punctuation.special"] = { fg = c.punct },
    ["@string"] = { fg = c.string },
    ["@string.escape"] = { fg = c.type },
    ["@string.regex"] = { fg = c.warn },
    ["@string.special"] = { fg = c.type },
    ["@tag"] = { fg = c.tag, bold = true },
    ["@tag.attribute"] = { fg = c.type },
    ["@tag.delimiter"] = { fg = c.punct },
    ["@type"] = { fg = c.type },
    ["@type.builtin"] = { fg = c.storage, bold = true },
    ["@type.definition"] = { fg = c.type },
    ["@type.qualifier"] = with_user_style({ fg = c.storage, bold = true }, keyword_style),
    ["@variable"] = with_user_style({ fg = c.fg }, variable_style),
    ["@variable.builtin"] = { fg = c.storage, bold = true },
    ["@variable.member"] = { fg = c.fg },
    ["@variable.parameter"] = { fg = c.fg_alt },

    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@annotation" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.macro"] = { link = "@constant.macro" },
    ["@lsp.type.method"] = { link = "@function.call" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type.definition" },
    ["@lsp.type.variable"] = { link = "@variable" },

    TelescopeNormal = { fg = c.fg, bg = bg_float },
    TelescopeBorder = { fg = c.border, bg = bg_float },
    TelescopePromptNormal = { fg = c.fg, bg = bg_float },
    TelescopePromptBorder = { fg = c.border, bg = bg_float },
    TelescopePromptPrefix = { fg = c.storage },
    TelescopeSelection = { fg = c.fg, bg = c.bg_pmenu_sel, bold = true },
    TelescopeMatching = { fg = c.storage, bold = true },
    TelescopeTitle = { fg = c.storage, bold = true },
    TelescopePromptTitle = { fg = c.bg, bg = c.storage, bold = true },
    TelescopePreviewTitle = { fg = c.bg, bg = c.info, bold = true },
    TelescopeResultsTitle = { fg = c.bg, bg = c.type, bold = true },
    TelescopeSelectionCaret = { fg = c.storage },
    TelescopeMultiSelection = { fg = c.storage, bold = true },
    TelescopePromptCounter = { fg = c.fg_dim },

    WhichKey = { fg = c.storage, bold = true },
    WhichKeyGroup = { fg = c.type },
    WhichKeyDesc = { fg = c.fg },
    WhichKeySeparator = { fg = c.punct },
    WhichKeySeperator = { fg = c.punct },
    WhichKeyValue = { fg = c.fg_dim },
    WhichKeyBorder = { fg = c.border, bg = bg_float },
    WhichKeyFloat = { fg = c.fg, bg = bg_float },
    WhichKeyNormal = { fg = c.fg, bg = bg_float },
    WhichKeyIcon = { fg = c.storage },

    CmpDocumentation = { fg = c.fg, bg = bg_float },
    CmpDocumentationBorder = { fg = c.border, bg = bg_float },
    CmpItemAbbr = { fg = c.fg },
    CmpItemAbbrDeprecated = { fg = c.fg_dim, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.storage, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.storage, bold = true },
    CmpItemKind = { fg = c.type },
    CmpItemMenu = { fg = c.fg_dim },
    CmpGhostText = { fg = c.fg_dim, italic = true },
    CmpItemKindDefault = { fg = c.type },
    CmpItemKindText = { fg = c.fg },
    CmpItemKindMethod = { fg = c.func },
    CmpItemKindFunction = { fg = c.func },
    CmpItemKindConstructor = { fg = c.type },
    CmpItemKindField = { fg = c.fg },
    CmpItemKindVariable = { fg = c.fg },
    CmpItemKindClass = { fg = c.type },
    CmpItemKindInterface = { fg = c.type },
    CmpItemKindModule = { fg = c.type },
    CmpItemKindProperty = { fg = c.fg },
    CmpItemKindUnit = { fg = c.number },
    CmpItemKindValue = { fg = c.number },
    CmpItemKindEnum = { fg = c.type },
    CmpItemKindKeyword = { fg = c.keyword, bold = true },
    CmpItemKindSnippet = { fg = c.string },
    CmpItemKindColor = { fg = c.string },
    CmpItemKindFile = { fg = c.fg },
    CmpItemKindReference = { fg = c.type },
    CmpItemKindFolder = { fg = c.storage },
    CmpItemKindEnumMember = { fg = c.constant },
    CmpItemKindConstant = { fg = c.constant },
    CmpItemKindStruct = { fg = c.type },
    CmpItemKindEvent = { fg = c.keyword },
    CmpItemKindOperator = { fg = c.operator },
    CmpItemKindTypeParameter = { fg = c.type },

    NeoTreeNormal = { fg = c.fg, bg = bg_alt },
    NeoTreeNormalNC = { fg = c.fg, bg = bg_alt },
    NeoTreeEndOfBuffer = { fg = bg_alt, bg = bg_alt },
    NeoTreeVertSplit = { fg = c.border, bg = bg_alt },
    NeoTreeWinSeparator = { fg = c.border, bg = bg_alt },
    NeoTreeRootName = { fg = c.storage, bold = true },
    NeoTreeDirectoryName = { fg = c.fg },
    NeoTreeDirectoryIcon = { fg = c.storage },
    NeoTreeFileName = { fg = c.fg },
    NeoTreeFileNameOpened = { fg = c.fg_alt, italic = true },
    NeoTreeFileIcon = { fg = c.type },
    NeoTreeIndentMarker = { fg = c.border },
    NeoTreeExpander = { fg = c.punct },
    NeoTreeCursorLine = { bg = c.bg_pmenu_sel },
    NeoTreeFloatBorder = { fg = c.border, bg = bg_float },
    NeoTreeFloatTitle = { fg = c.storage, bg = bg_float, bold = true },
    NeoTreeTitleBar = { fg = c.bg, bg = c.storage, bold = true },
    NeoTreeGitAdded = { fg = c.hint },
    NeoTreeGitDeleted = { fg = c.error },
    NeoTreeGitModified = { fg = c.warn },
    NeoTreeGitConflict = { fg = c.error, bold = true },
    NeoTreeGitIgnored = { fg = c.fg_dim },
    NeoTreeGitUntracked = { fg = c.hint },

    TodoBgFIX = { fg = c.bg, bg = c.error, bold = true },
    TodoBgHACK = { fg = c.bg, bg = c.warn, bold = true },
    TodoBgWARN = { fg = c.bg, bg = c.warn, bold = true },
    TodoBgPERF = { fg = c.bg, bg = c.info, bold = true },
    TodoBgNOTE = { fg = c.bg, bg = c.hint, bold = true },
    TodoBgTEST = { fg = c.bg, bg = c.storage, bold = true },
    TodoFgFIX = { fg = c.error, bold = true },
    TodoFgHACK = { fg = c.warn, bold = true },
    TodoFgWARN = { fg = c.warn, bold = true },
    TodoFgPERF = { fg = c.info, bold = true },
    TodoFgNOTE = { fg = c.hint, bold = true },
    TodoFgTEST = { fg = c.storage, bold = true },
    TodoSignFIX = { fg = c.error },
    TodoSignHACK = { fg = c.warn },
    TodoSignWARN = { fg = c.warn },
    TodoSignPERF = { fg = c.info },
    TodoSignNOTE = { fg = c.hint },
    TodoSignTEST = { fg = c.storage },

    FidgetTask = { fg = c.fg_dim },
    FidgetTitle = { fg = c.storage, bold = true },
    FidgetDone = { fg = c.hint },
    FidgetSpinner = { fg = c.info },

    CratesNvimLoading = { fg = c.info },
    CratesNvimVersion = { fg = c.fg },
    CratesNvimPreRelease = { fg = c.warn },
    CratesNvimYanked = { fg = c.error, strikethrough = true },
    CratesNvimNoMatch = { fg = c.fg_dim },
    CratesNvimUpgrade = { fg = c.hint, bold = true },
    CratesNvimError = { fg = c.error },

    LeapMatch = { fg = c.bg, bg = c.warn, bold = true },
    LeapLabelPrimary = { fg = c.bg, bg = c.storage, bold = true },
    LeapLabelSecondary = { fg = c.bg, bg = c.info, bold = true },
    LeapBackdrop = { fg = c.fg_dim },

    -- Rust legacy syntax fallback (when tree-sitter is unavailable/disabled).
    rustStructure = { fg = c.storage, bold = true },
    rustTypedef = { fg = c.storage, bold = true },
    rustStorage = { fg = c.storage, bold = true },
    rustSigil = { fg = c.operator },
    cType = { fg = c.storage, bold = true },
    goType = { fg = c.storage, bold = true },
    javaType = { fg = c.storage, bold = true },

    NvimTreeNormal = { fg = c.fg, bg = bg_alt },
    NvimTreeNormalNC = { fg = c.fg, bg = bg_alt },
    NvimTreeRootFolder = { fg = c.storage, bold = true },
    NvimTreeGitDirty = { fg = c.warn },
    NvimTreeGitNew = { fg = c.hint },
    NvimTreeGitDeleted = { fg = c.error },
    NvimTreeSpecialFile = { fg = c.type, underline = true },
  }
end

local function set_terminal_colors(c)
  for index, color in ipairs(c.terminal) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

function M.load(style, colors_name)
  local opts = config.options
  local resolved_style = style or opts.style
  local c = palette.get(resolved_style)

  if not c then
    vim.notify("kintsugi.nvim: unknown style '" .. tostring(resolved_style) .. "', using dark", vim.log.levels.WARN)
    resolved_style = "dark"
    c = palette.get("dark")
  end

  vim.o.termguicolors = true
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = colors_name or (resolved_style == "dark" and "kintsugi" or ("kintsugi-" .. resolved_style))

  if opts.terminal_colors then
    set_terminal_colors(c)
  end

  util.apply(groups(c, opts))
end

return M
