vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.history = 10000

vim.opt.clipboard = "unnamedplus"
vim.o.errorbells = false
vim.o.visualbell = false
-- Tab
-- tabstopはTab文字を画面上で何文字分に展開するか
-- shiftwidthはcindentやautoindent時に挿入されるインデントの幅
-- softtabstopはTabキーの空白の量，0の場合はtabstopと同じ，BSにも影響する
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 0
vim.o.expandtab = true -- expand tab to spaces
vim.o.autoindent = true
vim.o.smartindent = true
--vim.o.list = true
--vim.o.listchars = "tab:» "

-- Insert
vim.o.backspace = "indent,eol,start"
vim.o.formatoptions = vim.o.formatoptions .. "m" -- 整形オプション，マルチバイト系を追加

-- Command
vim.o.wildmenu = true
vim.o.wildmode = "longest,list,full" -- リスト表示、最長マッチ

-- Search
vim.o.wrapscan = true -- 最後まで検索したら先頭へ戻る
vim.o.ignorecase = true -- 大文字小文字無視
vim.o.smartcase = true -- 大文字ではじめたら大文字小文字無視しない
vim.o.incsearch = true -- インクリメンタルサーチ
vim.o.hlsearch = true -- 検索文字をハイライト

-- File
vim.o.autoread = true -- 他で書き換えられたら自動で読み直す
vim.o.swapfile = false -- スワップファイル作らない
vim.o.hidden = true -- 編集中でも他のファイルを開けるようにする
vim.o.backup = false
vim.o.updatecount = 100
vim.o.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.local/share/nvim/undo'
