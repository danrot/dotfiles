require('packer').startup(function(use)
	use 'gpanders/editorconfig.nvim'
	use {
		'hrsh7th/cmp-nvim-lsp',
		requires = {
			{'hrsh7th/nvim-cmp'},
		},
	}
	use 'kylechui/nvim-surround'
	use 'lewis6991/gitsigns.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'mfussenegger/nvim-fzy'
	use 'mfussenegger/nvim-lint'
	use 'norcalli/nvim-colorizer.lua'
	use 'numToStr/Comment.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/nvim-treesitter-context'
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use {
		'rcarriga/nvim-dap-ui',
		requires = {
			{'mfussenegger/nvim-dap'},
			{'nvim-neotest/nvim-nio'},
		},
	}
	use 'wbthomason/packer.nvim'
	use {
		'williamboman/mason-lspconfig.nvim',
		requires = {
			{'williamboman/mason.nvim'},
			{'neovim/nvim-lspconfig'},
		},
	}
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'
end)

vim.g.mapleader = ' '

vim.g.netrw_banner = false
vim.g.netrw_sort_sequence = '\\/$,*'
vim.g.netrw_sort_options = 'i'

vim.opt.termguicolors = true

vim.opt.title = true

vim.opt.showtabline = 2

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.number = true
vim.opt.rnu = true

vim.opt.laststatus = 3
vim.opt.fillchars = {
	eob = ' ',
}

vim.opt.mouse = ''

vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false

vim.opt.grepprg = 'rg --vimgrep'

vim.keymap.set('n', ']l', '<cmd>lnext<cr>')
vim.keymap.set('n', '[l', '<cmd>lprevious<cr>')
vim.keymap.set('n', ']q', '<cmd>cnext<cr>')
vim.keymap.set('n', '[q', '<cmd>cprevious<cr>')

vim.diagnostic.config({
	severity_sort = true,
})

vim.cmd('colorscheme danrot')

vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		if args.match == 'markdown' then
			vim.opt.spell = true
		end
	end
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
	callback = function (args)
		vim.fn.feedkeys('<CR>')
		if args.match:sub(1, 1) == 'l' then
			vim.cmd('lwindow')
		else
			vim.cmd('cwindow')
		end
	end
})

function Tabline()
	local tabs = {}
	local tab_length = vim.fn.tabpagenr('$')
	local tabline_length = 0

	for index = 1, tab_length do
		local winnr = vim.fn.tabpagewinnr(index)
        local buflist = vim.fn.tabpagebuflist(index)
        local bufnr = buflist[winnr]
        local bufname = vim.fn.bufname(bufnr)
		local bufmodified = vim.fn.getbufvar(bufnr, '&mod')
		local title = vim.fn.fnamemodify(bufname, ':~:.')
		local width = tostring(index):len() + title:len() + 4

		tabline_length = tabline_length + width

		table.insert(
			tabs,
			{
				title = title,
				bufmodified = bufmodified,
				width = width,
			}
		)
	end

	local tabline_length_diff = math.ceil(tabline_length - vim.o.columns)
	local shorten_title = tabline_length_diff > 0

	local tabline = ''
	for index, tab in ipairs(tabs) do
		local modifier = (tab.bufmodified == 1 and 'Mod' or '')
		local tabline_used_part = tab.width / tabline_length;

		tabline = tabline
			.. (index == vim.fn.tabpagenr() and '%#TabLineSel' .. modifier .. '#' or '%#TabLine' .. modifier ..'#')
			.. ' ' .. index .. ': '
			.. (shorten_title
				and string.sub(tab.title, math.ceil(tabline_length_diff * tabline_used_part) + 1, -1)
				or tab.title
			)
			.. ' %#TabLineFill#%T'
	end

	return tabline
end

vim.opt.tabline = '%!v:lua.Tabline()'

local cmp = require('cmp')
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local snippets_by_filetype = {
	javascript = {
		{
			trigger = 'cl',
			body = 'console.log($0);',
		},
	},
	markdown = {
		{
			trigger = 'cbash',
			body = '```bash\n$0\n```',
		},
		{
			trigger = 'chtml',
			body = '```html\n$0\n```',
		},
		{
			trigger = 'cjs',
			body = '```javascript\n$0\n```',
		},
		{
			trigger = 'cphp',
			body = '```php\n$0\n```',
		},
		{
			trigger = 'cplain',
			body = '```plaintext\n$0\n```',
		},
		{
			trigger = 'cxml',
			body = '```xml\n$0\n```',
		},
	},
	php = {
		{
			trigger = 'dt',
			body = 'declare(strict_types=1);',
		},
		{
			trigger = 'vd',
			body = 'var_dump($0);',
		},
		{
			trigger = 'vdd',
			body = 'var_dump($0);die();',
		},
	},
	sh = {
		{
			trigger = '!bash',
			body = '#!/bin/bash',
		},
	},
}

local snippets_buffer_cache = {}
cmp.register_source('snippets', {
	complete = function(_, _, callback)
		local bufnr = vim.api.nvim_get_current_buf()

		if not snippets_buffer_cache[bufnr] then
			local filetype = vim.bo.filetype

			snippets_buffer_cache[bufnr] = snippets_by_filetype[filetype]
				and vim.tbl_map(function(snippet)
					return {
						word = snippet.trigger,
						label = snippet.trigger,
						kind = vim.lsp.protocol.CompletionItemKind.Snippet,
						insertText = snippet.body,
						insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
					}
				end, snippets_by_filetype[filetype])
				or nil
		end

		callback(snippets_buffer_cache[bufnr])
	end
})

cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
		{name = 'snippets'},
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<Cr>'] = cmp.mapping.confirm(),
		['<Tab>'] = cmp.mapping(function(fallback)
			if vim.snippet.active({direction = 1}) then
				vim.snippet.jump(1)
			else
				fallback()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if vim.snippet.active({direction = -1}) then
				vim.snippet.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),
	},
})

require('nvim-surround').setup()

require('gitsigns').setup({
	signs_staged_enable = false
})

require('ibl').setup({
	indent = {
		char = '▏',
	},
})

vim.keymap.set('n', ']c', '<cmd>Gitsign next_hunk<cr>')
vim.keymap.set('n', '[c', '<cmd>Gitsign prev_hunk<cr>')
vim.keymap.set('n', '<leader>ga', '<cmd>!git add %<cr><cr>')

local lint = require('lint')

lint.linters_by_ft = {
	css = {'stylelint'},
	html = {'tidy'},
	javascript = {'eslint'},
	markdown = {'markdownlint'},
	php = {'phpstan'},
	scss = {'stylelint'},
	typescript = {'eslint'},
	vue = {'eslint', 'stylelint'},
}

vim.api.nvim_create_autocmd(
	{'BufWritePost'},
	{
		callback = function()
			lint.try_lint(nil, {ignore_errors = true})
		end
	}
)

require('colorizer').setup()

local dap = require('dap')

local xdebug_port = os.getenv('NVIM_XDEBUG_PORT')
local xdebug_path_server = os.getenv('NVIM_XDEBUG_PATH_SERVER')
local xdebug_path_local = os.getenv('NVIM_XDEBUG_PATH_LOCAL')

if (xdebug_port) then
	dap.adapters.php = {
		type = 'executable',
		command = 'node',
		args = {vim.fn.stdpath('data') .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js'},
	}

	dap.configurations.php = {
		{
			type = 'php',
			request = 'launch',
			name = 'Listen for Xdebug',
			port = xdebug_port,
			pathMappings = xdebug_path_local and xdebug_path_server
				and {
					[xdebug_path_server] = xdebug_path_local,
				}
				or nil,
		},
	}
end

vim.keymap.set('n', '<F2>', dap.step_over)
vim.keymap.set('n', '<F3>', dap.step_into)
vim.keymap.set('n', '<F4>', dap.step_out)
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.terminate)
vim.keymap.set('n', '<F9>', dap.run_to_cursor)
vim.keymap.set('n', '<F10>', dap.toggle_breakpoint)

local dapui = require('dapui')
dapui.setup({
	layouts = {
		{
			elements = {
				'stacks',
				'scopes',
			},
			size = 0.25,
			position = 'bottom',
		},
		{
			elements = {
				'watches',
				'breakpoints',
			},
			size = 40,
			position = 'left',
		},
	},
	icons = {
		collapsed = '▶',
		current_frame = '▶',
		expanded = '▼',
	},
})

-- Taken and adjusted from https://github.com/rcarriga/nvim-dap-ui/issues/122#issuecomment-1196748175
local dapui_tab = nil

dap.listeners.after.event_initialized["dapui_config"] = function()
	vim.api.nvim_exec('tabedit %', false)
	vim.api.nvim_exec('tabmove 0', false)
	dapui_tab = vim.api.nvim_win_get_tabpage(vim.fn.win_getid())
	dapui.open()
end

dap.listeners.before.disconnect["dapui_config"] = function()
	dapui.close()
	vim.api.nvim_exec('tabclose ' .. vim.api.nvim_tabpage_get_number(dapui_tab), false)
	dapui_tab = nil
end

require('Comment').setup()

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict

	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed
		}
	end
end

require('lualine').setup({
	sections = {
		lualine_b = {
			{'b:gitsigns_head'},
			{'diff', source = diff_source},
			'diagnostics',
		}
	},
	options = {
		component_separators = '|',
		disabled_filetypes = {'dapui_stacks', 'dapui_scopes', 'dapui_watches', 'dapui_breakpoints', 'help'},
		icons_enabled = false,
		section_separators = '',
	}
})

local fzy = require('fzy')

vim.keymap.set('n', '<leader>ff', function() fzy.execute('fd -t f -u -E .git', fzy.sinks.edit_file) end)
vim.keymap.set(
	'n',
	'<leader>fg',
	function()
		fzy.execute('git status --porcelain --untracked-files=all | rg "^.[AMU\\?]" | cut -c 4-', fzy.sinks.edit_file)
	end
)

require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'bash',
		'bibtex',
		'comment',
		'css',
		'diff',
		'dockerfile',
		'dot',
		'fish',
		'git_config',
		'git_rebase',
		'gitcommit',
		'gitignore',
		'graphql',
		'html',
		'java',
		'javascript',
		'json',
		'lua',
		'make',
		'markdown',
		'php',
		'scss',
		'sql',
		'twig',
		'typescript',
		'vimdoc',
		'vue',
		'xml',
		'yaml',
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	textobjects = {
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				[']m'] = '@function.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
			},
		},
		select = {
			enable = true,
			keymaps = {
				['am'] = '@function.outer',
				['im'] = '@function.inner',
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['ad'] = '@assignment.outer',
				['id'] = '@assignment.inner',
			},
		},
	},
})

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		'bashls',
		'cssls',
		'html',
		'jsonls',
		'lua_ls',
		'phpactor',
		'ts_ls',
		'volar',
	}
})

local lspconfig = require('lspconfig')

require('mason-lspconfig').setup_handlers {
	function (server_name)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local settings = {}

		if server_name == 'html' or server_name == 'cssls' then
			capabilities.textDocument.completion.completionItem.snippetSupport = true
		end

		if server_name == 'lua_ls' then
			settings.Lua = {
				diagnostics = {
					globals = {'vim'},
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file('', true),
				},
			}
		end

		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_init = function(client)
				client.server_capabilities.semanticTokensProvider = false
			end,
			settings = settings,
		})
	end,
}

vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set({'n', 'x'}, 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

require('nvim-autopairs').setup()
require('nvim-ts-autotag').setup()
