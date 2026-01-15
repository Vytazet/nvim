vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/karb94/neoscroll.nvim" },
    { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/Julian/lean.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- treesitter configuration
local file_types = {"cpp", "latex", "lua", "python" }
require("nvim-treesitter").install(file_types)

vim.api.nvim_create_autocmd('PackChanged', {
    desc = 'Handle nvim-tree-sitter updates',
    callback = function(event)
        if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
            pcall(vim.cmd, 'TSUpdate')
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = file_types,
    callback = function()
        vim.treesitter.start()
    end,
})

-- vimtex configuration
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_indent_on_ampersands = 0
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {aux_dir = "aux_files"}

-- vim.cmd("colorscheme catppuccin")
vim.cmd("colorscheme gruvbox")

require("mini.icons").setup()
require("mini.pick").setup({
    mappings = {
        choose_marked = "<A-CR>"
    }
})
require("mini.pairs").setup()
require("neoscroll").setup()
require("oil").setup({
    keymaps = {
        ["<C-h>"] = false,
    }
})

require("lean").setup({ mappings = true })
require("mason").setup()
require("lualine").setup({ options = { theme = "auto" } })
require("nvim-surround").setup()
require("which-key").setup({
    delay = 0,
    preset = "helix",
    icons = {
        mappings = true,
    },
    spec = {},
})

-- lsp configuration
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end

        if client:supports_method('textDocument/code_action') then
            vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action)
        end

        vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float)
    end,
})

vim.lsp.enable({"lua_ls", "clangd", "texlab"})

-- options and keymaps
require("options")
require("keymaps")

