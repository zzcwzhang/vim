" 自动安装vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"单词修复与扩展"
:iabbrev retrun return
:iabbrev cosnt const
:iabbrev thne then
:iabbrev adn and
:iabbrev atuo auto
:iabbrev flase false
:iabbrev ture true
:iabbrev sjon json
:iabbrev rul url
:iabbrev imoprt import
:iabbrev improt import
:iabbrev ipmrot import
:iabbrev cosnt const
:iabbrev stirng string
:iabbrev flaot float

" 基础配置 ---------------------- {{{
" 重要的全局配置
let mapleader=","
set mouse=a
set nocompatible
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set nobackup
set noswapfile
set history=100
" 缓冲文件swp swo等
set directory=/tmp "存放路径
"中文编码
set encoding=utf-8
let &termencoding=&encoding
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
filetype off                  " required!
set nocompatible "使用非兼容模式，就不会默认为vi模式了"
set nu
syntax enable
set hlsearch
set incsearch
set showmode
set ruler
set tabstop=2
set shiftwidth=2
set helplang=cn
set background=dark
set nrformats=octal,hex
colorscheme solarized
"split the screen
set splitbelow
set splitright

"窗口间快速移动
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"快速行首行尾
vnoremap L $
vnoremap H ^
nnoremap L $
nnoremap H ^
" vnoremap g y/<C-r>0<cr> "快速查找当前选择的部分

" 强化翻页
nnoremap <Up> <c-b>
nnoremap <Down> <c-f>
nnoremap <Left> gT
nnoremap <Right> gt
"折叠
" set foldmethod=manual
set foldlevel=99
set nocompatible              " required
"开启文件类型匹配"

augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

"单词包围,自动添加"('等符号在一个单词左右
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel

"快速编写自定义宏"
" nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
"
" 快速打开~/.bash_profile
nnoremap <leader>eb :vsplit ~/.bash_profile<cr>
nnoremap <leader>sb :!source ~/.bash_profile<cr>
" 快速打开~/.zshrc
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
nnoremap <leader>sb :source ~/.zshrc<cr>

"重新加载vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"快速打开.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"快速打开百度
nnoremap <Leader>bd :!python2 /Users/apple/baidu.py<cr>

"使用有道查找当前光标单词
nnoremap <Leader>yd :!python2 /Users/apple/youdao.py <cword><cr>

"Y复制到系统粘贴板
vnoremap gy "+y
nnoremap gp "+p

"使用黑洞寄存器删除
nnoremap D "_dd
vnoremap D "_d

"删除当前行到黑洞并用粘贴
vnoremap P "_dP

"json格式化 需要brew install jq
com! JsonFormat %!jq .

"强化退出
inoremap jk <esc>

"选择强化"
onoremap p i(
onoremap " F"f"
onoremap ' F'f'


augroup base
	autocmd!
	"每次打开文件恢复光标位置
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif

	"当前行高亮，插入模式下取消"
	autocmd InsertLeave,WinEnter * set cursorline
	autocmd InsertEnter,WinLeave * set nocursorline
augroup END

"到同名后缀文件"

"光标配置
"http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"


"加载插件
call plug#begin('~/.vim/plugged')

" Ack代替grep
Plug 'mileszs/ack.vim'

" 括号自动环绕
Plug 'tpope/vim-surround'

"代码片段
" 使用新版的代码片段引擎
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Optional:
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

Plug 'styled-components/vim-styled-components'
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" -----------------------------------------------
" 代码注释
" -----------------------------------------------
"  <leader>cc 加注释
"  <leader>cu 揭开注视
"  <leader>c<space> 加上/解开注释，智能判断
"  <leader>cy 先复制， 在注释（p可以进行黏贴
Plug 'scrooloose/nerdcommenter'

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
			\ 'javascript': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' },
			\ 'less': { 'left': '/*', 'right': '*/' }
			\ }

let g:NERDAltDelims_javascript = 1
let g:NERDDefaultNesting = 1

"目录级搜索
Plug 'kien/ctrlp.vim'
"快捷键
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'
" 设置搜索时忽略的文件
let g:ctrlp_custom_ignore = {
			\ 'dir': '\v[\/](.git|.hg|.svn|.rvm|node_modules|Go2Shell.app)$',
			\ 'file': '\v\.(DS_Store|swp|exe|so|dll|zip|tar|tar.gz|pyc)$',
			\ }
"修改QuickFix窗口现实的最大条目数
let g:ctrlp_max_height = 15
let g:ctrlp_match_window_reversed = 0

"使用按文件名搜索，而不是默认的按路径名
let g:ctrlp_follow_symlinks = 1
"自定义搜索列表的提示符
let g:ctrlp_line_prefix = '♪ '


"文件树
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
nnoremap <leader>mt :NERDTreeToggle<CR>
"NERDTree导航设置"
let g:NERDTreeGitStatusIndicatorMapCustom= {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp'] "忽略以下文件
let NERDTreeShowLinenumbers = 1 "设置行号
let g:nerdtree_tabs_open_on_console_startup=1 "在终端启动vim时共享NERDTree


Plug 'isRuslan/vim-es6'

"Git配置"
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter.git'


"符号自动环绕
" Plug 'tpope/vim-surround'


"前端配置"
Plug 'mattn/emmet-vim'

" vim-powerline插件
Plug 'https://github.com/Lokaltog/vim-powerline.git'
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'unicode'


" 语言配置 ---------------------- {{{
let g:user_emmet_install_global = 1

let g:prettier#config#single_quote = 'true'
let g:prettier#config#jsx_single_quote = 'true'
let g:prettier#config#print_width = '100'
let g:prettier#config#bracket_spacing = 'true'

"复制当前选中的文本到一个新的临时Buffer
function! BufferTemporary()
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	vsplit __Buffer_Temporary__
	normal! ggdG
	setlocal filetype=javascript
	setlocal buftype=nofile
	call append(0, lines)
endfunction

"Node
augroup node
	autocmd!
	autocmd FileType javascript set dictionary+=$VIM.'\vimfiles\dict\node.dict'
	autocmd FileType javascript nnoremap <buffer> <F5> :!node %<cr>
	autocmd FileType javascript nnoremap <buffer> <F6> :!mocha %<cr>
	autocmd FileType javascript nnoremap <buffer> <F7> :call EslintShow()<cr>
	autocmd FileType javascript vnoremap <buffer> B :call BufferTemporary()<cr>
augroup END

"Js eslint"
function! EslintShow()
	let output = system("eslint " . bufname("%"))
	vsplit __Eslinet_Output__
	normal! ggdG
	setlocal filetype=eslintoutput
	setlocal buftype=nofile
	call append(0,split(output,'\v\n'))
endfunction

"Vim
augroup vim
	autocmd!
	autocmd FileType vim nnoremap <buffer> <F5> :source %<cr>
augroup END

Plug 'pangloss/vim-javascript'
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 0
let g:javascript_plugin_flow = 0
augroup javascript_folding
		au!
		au FileType javascript setlocal foldmethod=syntax
augroup END
Plug 'maxmellon/vim-jsx-pretty'

let g:jsx_improve_motion_disable = 1

call plug#end()
