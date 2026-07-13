vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- システムクリップボードを使用
opt.clipboard = "unnamedplus"

-- 行番号
opt.number = true
opt.relativenumber = true

-- カーソル行を強調
opt.cursorline = true

-- インデント
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- 折り返し
opt.wrap = false

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 画面表示
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8

-- コマンド・補完
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cmdheight = 1
opt.showmode = true 

-- ファイル操作
opt.swapfile = true 
opt.backup = false
opt.undofile = true

-- 更新速度
opt.updatetime = 250
opt.timeoutlen = 300

-- 分割画面の開く方向
opt.splitright = true
opt.splitbelow = true

-- 空白文字を表示
opt.list = true
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- マウス操作を有効化
opt.mouse = "a"

-- true color対応端末で色を正しく表示
opt.termguicolors = true
