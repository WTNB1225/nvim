vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true })

-- 画面分割
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", { desc = "左右に分割" })
vim.keymap.set("n", "<leader>hs", "<cmd>split<CR>", { desc = "上下に分割" })

-- 分割画面を閉じる
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "現在の画面を閉じる" })

-- 分割画面間の移動
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "左へ移動" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "下へ移動" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "上へ移動" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "右へ移動" })

-- バッファ移動
vim.keymap.set("n", "H", "<cmd>bprevious<CR>", { desc = "前のバッファ" })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "次のバッファ" })

-- バッファを閉じる
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "バッファを閉じる" })

-- バッファ一覧
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "バッファ一覧" })