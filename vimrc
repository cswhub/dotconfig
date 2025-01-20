"===语法===
"noremap：这个前缀表示创建一个非递归的映射，这意味着映射不会被再次映射。
"map：这是创建普通模式映射的命令。如果你想要在插入模式下也使用这个映射，可以使用 imap 代替 map。


"vim-plug安装
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


set nocompatible "关闭与vi的兼容
let &t_ut='' "用于重置终端的 t_ut 选项,设置为空是为了清除初始化选项
set mouse=a "设置鼠标支持
set noeb "关闭响铃
set cursorline "高亮显示当前光标所在的行
let mapleader=" " "用于设置默认的领导键(mapleader)
autocmd BufWritePost $MYVIMRC source $MYVIMRC "修改并保存你的 Vim 配置文件后立即重新加载配置文件

"===文本显示设置===
set wrap "设置文本的自动换行,nowrap是反设置
set linebreak "在换行时尽量在单词边界处断行
set breakindent "换行后的文本不会紧贴窗口边缘，而是有一定的缩进，使得阅读更加舒适
"===高亮设置===
syntax on "开启语法高亮
set showmatch "括号匹配高亮
set matchtime=2 "如果是=2,则是设置匹配括号显示时间为0.2秒
set number "设置行号显示
set relativenumber "设置相对行号

"===屏幕底部显示===
set showcmd "在命令模式下输入命令时，showcmd 选项会在屏幕底部显示你输入的命令
set ruler "这个设置用于在底部命令行区域显示光标位置和其他信息。
set showmode "这个设置用于在底部显示当前模式

"===补全===
"set wildmenu "开启增强模式的命令行补全功能set wildmode=longest:list,full和set wildignore=*.dll,*.exe,*.jpg,*.gif,*.png 有空再研究



filetype on "开启文件类型检测功能
filetype indent on "根据文件类型自动不同风格的缩进
filetype plugin on "根据文件类型加载特定的插件


set encoding=utf-8 "Vim 在启动时使用UTF-8作为默认的字符编码
set fileencoding=utf-8 "设置 Vim 读写文件时使用的编码
set fileencodings=utf-8,gbk "设置 Vim 尝试检测文件编码的顺序
set guifont=Consolas\ 18 "GUI模式下设置字体和字号


"你可以使用 za 来折叠或展开当前行,zM 来折叠所有内容,zR 来展开所有内容。
set foldenable "开启代码折叠功能
set foldmethod=indent "设置代码折叠方法,indent是基于缩进进行折叠
set foldlevel=99 "设置代码折叠的级别

set tabstop=4 "设置制表符占用的空格数
set shiftwidth=4 "设置用于定义在自动缩进时每个缩进级别使用的空格数,通常跟tabstop一致
"set expandtab "用于自动将制表符转换为相应数量的空格
"定义在插入和删除操作中制表符的行为 set softtabstop=4 

set hlsearch "设置搜索时高亮显示
exec "nohlsearch"
set incsearch "即时显示与当前已输入搜索词匹配的结果
set ignorecase "设置搜索时忽略大小写
set smartcase "搜索词中包含大写字母时才启用大小写敏感搜索


noremap <LEADER><CR> :nohlsearch<CR> "创建一个键位映射，用来取消高亮显示


"插件区

call plug#begin()

" 列出你的所有插件 :PlugInstall 来安装
Plug 'vim-airline/vim-airline'
Plug 'blueshirts/darcula'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

call plug#end()



colorscheme darcula "设置颜色方案，darcula是插件里的方案，必须先通过插件安装后才能使用，可简写为color darcula
"let g:SnazzyTransparent = 1 "设置snazzy的透明背景
map tt :NERDTreeToggle<CR> 

autocmd VimEnter * if !argc() | NERDTree | endif "可以用vim打开文件夹，然后就会自动启动nerdtree
let g:NERDTreeWinSize=30 "设置nerdtree的宽度
let g:NERDTreeShowHidden=1 "显示隐藏文件
let g:NERDTreeDirArrows=1 "目录箭头
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '__pycache__'] "忽略类型
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "如果退出窗口时，nerdtree是最后一个窗口，就自动关闭nerdtree
nnoremap <C-H> :wincmd < <CR> "缩小窗口
nnoremap <C-L> :wincmd > <CR> "放大窗口
" let NERDTreeMinimalUI=1
" 设置为双字宽显示，否则无法完整显示如:☆
set ambiwidth=double

" 总是显示签名列
set signcolumn=yes

" 一些 coc.nvim 的基本配置
set shortmess+=c
set noshowmode

" 补全选项配置
set completeopt=menuone,noinsert,noselect
set completeopt-=selectmode
" 使用 <TAB> 和 <S-TAB> 来导航补全列表
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" 其他快捷键配置
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! ToggleComment()
    if getline('.') =~ '^#'
        execute 's/^#//'
    else
        execute 's/^/#/'
    endif
endfunction
autocmd FileType python noremap <C-_> :call ToggleComment()<CR>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

