vim.g.colors_name = 'danrot'

local colors = {
	aquaForest = '#6AAB73',
	bermuda = '#83DDDB',
	carnation = '#F75464',
	cornflowerBlue = '#57AAF7',
	doveGray = '#666666',
	dustyGray = '#999999',
	mineShaft = '#333333',
	redDamask = '#DF853A',
	silver = '#CCCCCC',
	tundora = '#444444',
	viola = '#C77DBB',
	whiskey = '#D5B778',
	white = '#FFFFFF',
}

local hl = vim.api.nvim_set_hl

hl(0, 'Directory', {fg = colors.cornflowerBlue});

hl(0, 'VertSplit', {fg = colors.doveGray})

hl(0, 'TabLine', {fg = colors.doveGray, bg = colors.mineShaft})
hl(0, 'TabLineFill', {bg = colors.mineShaft})
hl(0, 'TabLineSel', {fg = colors.silver, bg = colors.tundora, bold = true})
hl(0, 'TabLineMod', {fg = colors.carnation})
hl(0, 'TabLineSelMod', {fg = colors.carnation, bg = colors.tundora, bold = true})

hl(0, 'Normal', {fg = colors.white, bg = colors.mineShaft})
hl(0, 'CursorLine', {bg = colors.tundora})

hl(0, 'NormalFloat', {bg = colors.tundora})

hl(0, 'Pmenu', {bg = colors.tundora})
hl(0, 'PmenuSel', {bg = colors.doveGray})

hl(0, 'Comment', {fg = colors.dustyGray})

hl(0, 'LineNrAbove', {fg = colors.doveGray})
hl(0, 'CursorLineNr', {fg = colors.silver})
hl(0, 'LineNrBelow', {fg = colors.doveGray})

hl(0, 'GitSignsAdd', {bg = colors.aquaForest})
hl(0, 'GitSignsChange', {bg = colors.whiskey})
hl(0, 'GitSignsDelete', {bg = colors.carnation})

hl(0, 'DiffAdd', {fg = colors.aquaForest})
hl(0, 'DiffChange', {fg = colors.whiskey})
hl(0, 'DiffDelete', {fg = colors.carnation})

hl(0, 'Visual', {bg = colors.doveGray})

hl(0, 'NonText', {fg = colors.doveGray})

hl(0, '@boolean', {fg = colors.redDamask})
hl(0, '@conditional', {fg = colors.redDamask})
hl(0, '@constructor', {fg = colors.cornflowerBlue})
hl(0, '@constant', {fg = colors.viola})
hl(0, '@constant.builtin', {fg = colors.redDamask})
hl(0, '@exception', {fg = colors.whiskey})
hl(0, '@field', {fg = colors.viola})
hl(0, '@function', {fg = colors.cornflowerBlue})
hl(0, '@function.builtin', {fg = colors.cornflowerBlue})
hl(0, '@include', {fg = colors.redDamask})
hl(0, '@keyword', {fg = colors.redDamask})
hl(0, '@label', {fg = colors.viola})
hl(0, '@method', {fg = colors.cornflowerBlue})
hl(0, '@namespace', {fg = colors.white})
hl(0, '@number', {fg = colors.bermuda})
hl(0, '@operator', {fg = colors.white})
hl(0, '@parameter', {fg = colors.viola})
hl(0, '@property', {fg = colors.viola})
hl(0, '@punctuation', {fg = colors.white})
hl(0, '@repeat', {fg = colors.redDamask})
hl(0, '@string', {fg = colors.aquaForest})
hl(0, '@string.escape', {fg = colors.redDamask})
hl(0, '@tag', {fg = colors.whiskey})
hl(0, '@diff.plus', {fg = colors.aquaForest})
hl(0, '@diff.minus', {fg = colors.carnation})
hl(0, '@markup.heading', {fg = colors.redDamask})
hl(0, '@markup.italic', {italic = true})
hl(0, '@markup.link', {fg = colors.viola})
hl(0, '@markup.link.label', {fg = colors.cornflowerBlue})
hl(0, '@markup.raw', {fg = colors.silver})
hl(0, '@markup.strong', {bold = true})
hl(0, '@type', {fg = colors.white})
hl(0, '@type.definition', {fg = colors.white})
hl(0, '@type.qualifier', {fg = colors.redDamask})
hl(0, '@variable', {fg = colors.viola})

hl(0, 'editorconfigProperty', {fg = colors.viola})
hl(0, 'dosiniLabel', {fg = colors.viola})
hl(0, 'dosiniValue', {fg = colors.aquaForest})

hl(0, 'jsonKeyword', {fg = colors.viola})
hl(0, 'jsonBraces', {fg = colors.white})
hl(0, 'jsonBoolean', {fg = colors.redDamask})
hl(0, 'jsonString', {fg = colors.aquaForest})
