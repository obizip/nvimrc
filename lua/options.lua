-- Base --
if vim.loop.os_uname().sysname == "Darwin" then
	vim.cmd("language en_US.UTF-8")
	vim.o.clipboard = "unnamedplus"
end
vim.g.encoding = "utf-8"
vim.g.fileencodings = "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1"
vim.o.history = 1000
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.spell = false
vim.o.backspace = "indent,eol,start"
vim.o.virtualedit = "none"
vim.o.formatoptions = vim.o.formatoptions .. "m" -- 整形オプション，マルチバイト系を追加

-- File --
vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true
vim.o.autoread = true
vim.o.autowrite = true

local undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
if not vim.fn.isdirectory(undodir) then
	vim.fn.mkdir(undodir, "p", 0770)
end
vim.o.undofile = true
vim.opt.undodir = undodir

-- Display --
vim.o.title = true
vim.o.termguicolors = true
vim.o.number = false
vim.o.cmdheight = 0
vim.o.showmode = false
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.showcmd = false
vim.o.laststatus = 1
vim.o.wildmenu = true
vim.o.wildmode = "list:longest,full"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.scrolloff = 4
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("tab:▸-")
vim.o.conceallevel = 0
vim.o.concealcursor = ""

-- Tab & Indent --
vim.o.tabstop = 4 -- only set tabstop
vim.o.shiftwidth = 0 -- tabstopに従う
vim.o.softtabstop = -1 -- shiftwidthに従う
vim.o.expandtab = true -- expand tab to spaces
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = "+ "
vim.o.breakindent = true

-- Search --
vim.o.wrapscan = true -- 最後まで検索したら先頭へ戻る
vim.o.ignorecase = true -- 大文字小文字無視
vim.o.smartcase = true -- 大文字ではじめたら大文字小文字無視しない
vim.o.incsearch = true -- インクリメンタルサーチ
vim.o.hlsearch = true -- 検索文字をハイライト
