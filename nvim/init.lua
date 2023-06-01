require('packer').startup(function(use)
	use 'gpanders/editorconfig.nvim'
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			{'hrsh7th/cmp-nvim-lsp'},
			{
				'saadparwaiz1/cmp_luasnip',
				requires = {
					{'L3MON4D3/LuaSnip'}
				},
			},
		},
	}
	use 'kylechui/nvim-surround'
	use 'lewis6991/gitsigns.nvim'
	use 'mfussenegger/nvim-lint'
	use 'numToStr/Comment.nvim'
	use 'nvim-lualine/lualine.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '*',
		requires = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
		},
	}
	use 'nvim-treesitter/nvim-treesitter'
	use {
		'rcarriga/nvim-dap-ui',
		requires = {
			{'mfussenegger/nvim-dap'},
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
end)

vim.g.mapleader = ' '

vim.opt.termguicolors = true

vim.opt.title = true

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.rnu = true

vim.opt.mouse = 'a'

vim.opt.switchbuf = 'usetab,newtab'

vim.keymap.set('n', '<C-w>t', '<cmd>tab split<cr>')

vim.cmd('colorscheme desert')

vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		if args.match == 'netrw' then
			vim.cmd('syntax on')
		else
			vim.cmd('syntax off')
		end

		if args.match == 'markdown' then
			vim.opt.spell = true
		end
	end
})

local cmp = require('cmp')
local luasnip = require('luasnip')
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
require('luasnip.loaders.from_lua').lazy_load({paths = vim.fn.stdpath('config') .. '/snippets'})

cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<Cr>'] = cmp.mapping.confirm(),
		['<Tab>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),
		['<C-e>'] = cmp.mapping(function()
			luasnip.change_choice(1)
		end, {'i', 's'}),
	},
})

require('nvim-surround').setup()

require('gitsigns').setup()

vim.keymap.set('n', ']c', '<cmd>Gitsign next_hunk<cr>')
vim.keymap.set('n', '[c', '<cmd>Gitsign prev_hunk<cr>')

local lint = require('lint')

lint.linters_by_ft = {
	css = {'stylelint'},
	javascript = {'eslint'},
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

local dap = require('dap')

dap.defaults.fallback.switchbuf = 'uselast'

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

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.disconnect["dapui_config"] = function()
	dapui.close()
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
		icons_enabled = false,
		section_separators = '',
		component_separators = '|',
	}
})

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.load_extension('fzf')

telescope.setup({
	defaults = {
		file_ignore_patterns = {'.git'}
	}
})

vim.keymap.set('n', '<leader>ff', function() builtin.find_files{hidden = true} end)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fv', builtin.git_status)

require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'bash',
		'bibtex',
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
		'vue',
		'yaml',
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {'lua_ls', 'phpactor', 'volar'}
})

require('mason-lspconfig').setup_handlers {
	function (server_name)
		require('lspconfig')[server_name].setup({})
	end,
}

vim.diagnostic.config({
	severity_sort = true,
})

vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>rs', vim.lsp.buf.rename)
vim.keymap.set({'n', 'x'}, '<leader>ca', vim.lsp.buf.code_action)

require('nvim-autopairs').setup()
