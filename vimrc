"单词修复与扩展"
" :iabbrev retrun return
" :iabbrev thne then
" :iabbrev adn and
" :iabbrev atuo auto
" :iabbrev flase false
" :iabbrev ture true
" :iabbrev sjon json
" :iabbrev rul url

" 基础配置 ---------------------- {{{

"中文编码
set encoding=utf-8
let &termencoding=&encoding
set fileencodings=utf-8,gb18030,gbk,gb2312,big5

set nocompatible "使用非兼容模式，就不会默认为vi模式了"

" 重要的全局配置
let mapleader=" "

set nu
syntax enable
set hlsearch
set incsearch
set showmode
set ruler
set tabstop=4
set shiftwidth=4
set encoding=utf-8
set helplang=cn
set background=dark
set nrformats=
colorscheme evening
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
vnoremap H 0
nnoremap L $
nnoremap H 0
vnoremap g y/<C-r>0<cr> "快速查找当前选择的部分

"折叠
set foldmethod=indent
set foldlevel=99
set nocompatible              " required   
"开启文件类型匹配"
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" 强化翻页
nnoremap <Up> <c-b>
nnoremap <Down> <c-f>
nnoremap <Left> gT 
nnoremap <Right> gt

"单词包围,自动添加"('等符号在一个单词左右
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " %:h"<cr>:copen<cr>

"快速编写自定义宏"
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

"重新加载vimrc
nnoremap <leader>sv :source $MYVIMRC<cr> 

"快速打开.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"快速打开百度
nnoremap <Leader>bd :!python2 /Users/apple/baidu.py<cr>		

"使用有道查找当前光标单词
nnoremap <Leader>yd :!python2 /Users/apple/youdao.py <cword><cr>  

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
function! Gsf(hg)
	execute 'edit' fnamemodify(expand('%'),':r') . a:hg 	
endfunction

"注释函数"
function! Vimnote(notetext)
	exec "normal! i\" ".a:notetext." ---------------------- {{{"
	exec "normal! o }}} -".a:notetext." END"
endfunction


" }}}


" 语言配置 ---------------------- {{{

"PHP"
"在浏览器预览 for Mac
function! ViewInBrowser(name)
	let file = expand("%:p")
	let l:browsers = {
				\"cr":"open -a \"Google Chrome\"",
				\"ff":"open -a Firefox",
				\}
	let htdocs='/Library/WebServer/Documents/'
	let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
	let file = '"'. file . '"'
	exec ":update " .file
	"echo file .' ## '. htdocs
	if strpos == -1
		exec ":silent ! ". l:browsers[a:name] ." file://". file
	else
		let file=substitute(file, htdocs, "http://127.0.0.1:8088/", "g")
		let file=substitute(file, '\\', '/', "g")
		exec ":silent ! ". l:browsers[a:name] file
	endif
endfunction


"JAVA"
augroup javaconfig
	autocmd!
	"java自动补全
	autocmd FileType java setlocal omnifunc=javacomplete#Complete
	autocmd FileType java set omnifunc=javacomplete#Complete
	autocmd FileType java set completefunc=javacomplete#CompleteParamsInf
	autocmd FileType java inoremap <exxpr><CR> pumvisible()?"\<C-Y>":"<CR>"
	autocmd FileType java nnoremap <leader>p oSystem.out.println();<esc>hi
	"java自动运行"
	autocmd FileType java nnoremap <buffer> <F5> :!java %:r<cr>
	autocmd FileType java nnoremap <buffer> <F4> :!javac %<cr>
augroup END


"PYTHON"
function! PythonShow(python_command)
	let output = system(a:python_command . " " . bufname("%"))
	vsplit __Python_Output__
	normal! ggdG
	setlocal filetype=pythonoutput
	setlocal buftype=nofile
	call append(0,split(output,'\v\n'))
endfunction
augroup pythonconfig
	autocmd!
	"python3 F4启动"
	autocmd FileType python nnoremap <buffer> <F4> :!python3 %<cr>
	autocmd filetype python nnoremap <buffer> <F5> :!python %<cr>
	autocmd FileType python nnoremap <buffer> <localleader>m :call append(line("$"),"if __name__ == '__main__' :")<esc>
	autocmd FileType python nnoremap <buffer> <localleader>R :call PythonShow('python3')<cr>
	autocmd FileType python nnoremap <buffer> <localleader>r :call PythonShow('python')<cr>
	"表示不必要的空白字符
	autocmd BufNewFile,BufNewFile *.py*.pyw,*.c,*.h match BadWhitespace /\s\+$/
augroup END


"RUBY"
augroup rubyconfig
	autocmd!
	autocmd BufNewFile *.rb :call setline(1,"#coding:utf-8")
	autocmd FileType ruby nnoremap <buffer> <F5> :!ruby %<cr>
augroup END

"  }}} -语言配置 END

" 第三方插件配置 ---------------------- {{{
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>	"转到定义

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kien/ctrlp.vim'
Plugin 'https://github.com/Lokaltog/vim-powerline.git'
Plugin 'groenewege/vim-less'
Plugin 'mattn/emmet-vim'

"国人写的终端插件
Plugin 'PangPangPangPangPang/vim-terminal'
map <silent> <leader>t :VSTerminalToggle<cr>
tmap <silent> <leader>t :VSTerminalToggle<cr>

"html xml自动闭合标签
Plugin 'docunext/closetag.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'AutoClose'
"swift
Plugin 'toyamarinyon/vim-swift'
"java
Plugin 'vim-scripts/javacomplete'

"Git配置"
Plugin 'tpope/vim-fugitive'

"注释插件vim-commentary
" 注释插件
augroup commentary
	autocmd!
	autocmd FileType python,shell set commentstring=#\ %s  "设置Python注释字符
	autocmd FileType mako set cms=##\ %s
	"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
augroup END
Bundle "tpope/vim-commentary"

"Tagbar
Plugin 'majutsushi/tagbar'
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=30
let g:tagbar_right=1
map <F8> :TagbarToggle<CR>


filetype plugin on
"自动补全用Vundle安装YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

"符号自动环绕
Plugin 'tpope/vim-surround' 



"前端配置"
let g:user_emmet_install_global = 0
augroup filetype_web
	autocmd!
	autocmd FileType html,css,php EmmetInstall
augroup END


"pydiction 1.2 python auto complete
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
""defalut g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20"

" YouComplete
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_server_python_interpreter='/user/bin/python'

"NERDTree导航设置"
let g:NERDTreeIndicatorMapCustom = {
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
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
nnoremap <leader>mt :NERDTree<cr>

" vim-powerline插件
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'unicode'

"TagBar配置
nnoremap <Leader>md :TagbarToggle<CR>
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:tagbar_ctags_bin='ctags'

call vundle#end()
filetype plugin indent on

" }}} -第三方插件配置 END



"自定义函数
augroup self
	autocmd!
	"用法"
	":%s//\=Pxtovw(submatch(1))
	function! Pxtovw(num)
		let l:a = a:num / 12.0
		return printf('%.2fvw',l:a)
	endfunction
augroup END

