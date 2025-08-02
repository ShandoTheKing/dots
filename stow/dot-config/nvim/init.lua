--##############################################################################
--############################# GLOBAL OPTIONS #################################
--##############################################################################

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

vim.o.cmdheight = 0
vim.o.colorcolumn= "81"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true

vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣,"

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.equalalways = true
vim.o.winborder = "single"

vim.o.undofile = true
vim.o.confirm = true
vim.o.laststatus = 3

--##############################################################################
--################################# PLUGINS ####################################
--##############################################################################

vim.pack.add({
	{ src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/echasnovski/mini.completion" },
})

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "vim", "vimdoc", "arduino", "html", "css", "markdown", "markdown_inline", "nix" },
	auto_install = true,
	highlight = { enable = true }
}

require("mini.completion").setup({})

require("lsp.lua_ls")

--##############################################################################
--############################### Diagnostics ##################################
--##############################################################################

-- copied from kickstart.nvim on 2025-08-02
vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

--##############################################################################
--############################## COLOUR SCHEME #################################
--##############################################################################

vim.cmd.colorscheme "oxocarbon"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { fg = 5395026, bg = "none" })

--##############################################################################
--############################## AUTO COMMANDS #################################
--##############################################################################

-- Remove trailing whitespace
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*"},
  command = "%s/\\s\\+$//e",
})

-- Highlight when yanking (copied from kickstart.nvim 2025-08-02)
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Stop using lsp semantic tokens for highlighting
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})


--##############################################################################
--############################### KEYBINDINGS ##################################
--##############################################################################

vim.g.mapleader = " "

vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { noremap = true })
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d', { noremap = true })
vim.keymap.set({'n', 'v'}, '<esc><esc>', ':nohl<enter>', { noremap = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Force myself to use hjkl navigation
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
