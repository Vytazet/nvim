-- Making Q not map to anything
vim.keymap.set("", "Q", "<Nop>")

-- Moving through windows easier
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Centering after scrolling up or down
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Indenting in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Easy escape from terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keymaps related to mini.pick
vim.keymap.set("n", "<leader>f", MiniPick.builtin.files, { desc = "Telescope Find [F]iles" })
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep_live, { desc = "Telescope Live File [G]rep" })
vim.keymap.set("n", "<leader>h", MiniPick.builtin.help, { desc = "Telescope Find [H]elp" })
vim.keymap.set("n", "<leader>b", MiniPick.builtin.buffers, {desc = "Telescope Search [B]uffers" })
vim.keymap.set("n", "<leader>cn", function()
    MiniPick.builtin.files({}, { source = { cwd = "~/.config/nvim" } })
end, { desc = "[C]onfigure [N]eovim" })

-- Keymaps related to oil
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "[E]xplore current directory" })

-- Keymaps related to which-key
vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = true })
end)

-- Easier autocomplete
vim.keymap.set("i", "<C-Space>", "<C-X><C-O>")

-- Diagnostics help
vim.keymap.set("n", "<leader>q", function()
    if vim.tbl_isempty(vim.fn.getqflist()) then
        return
    end

    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd("cclose")
            return
        end
    end
    vim.cmd("copen")
end, { desc = "Toggle diagnostic [Q]uickfix list" })

