" Specify a directory for plugins For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Make sure you use single quotes

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mbbill/undotree'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'cocopon/iceberg.vim'
Plug 'majutsushi/tagbar'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'derekwyatt/vim-scala'
Plug 'tpope/vim-markdown'
Plug 'lervag/vimtex'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'luochen1990/rainbow'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'editorconfig/editorconfig-vim'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
" Initialize plugin system
call plug#end()
" [basic]
" -- from ruanyifeng
set shell=$SHELL
set title
set number
set autoindent
set shiftwidth=4
set expandtab
set cursorline
set textwidth=150
set linespace=3
set linebreak
set showbreak=...
set wrap
set scrolloff=10
set sidescrolloff=15
set showmatch
set smartcase
set autoread
set wildmenu
set wildmode=list:longest
syntax on
filetype indent on

" -- from nicknisi/dotfiles
" Tab control
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'

" code folding settings
set foldmethod=syntax " fold based on indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

if (has('nvim'))
" show results of substition as they're happening
" but don't open a split
    set inccommand=nosplit
endif

" make backspace behave in a sane manner
set backspace=indent,eol,start

" setup clipboard, see :help clipboard and :help 'clipboard'
set clipboard+=unnamedplus
if has('mouse')
    set mouse=a
endif

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros
set magic " Set magic on, for regex

" [leader]
let mapleader = ","
inoremap jk <esc>

" shortcut to save
nmap <leader>, :w<cr>

" edit ~/.config/nvim/init.vim
map <leader>ev :e! ~/.config/nvim/init.vim<cr>

" paste
set pastetoggle=<leader>v

" clear highlighted search
noremap <space> :set hlsearch! hlsearch?<cr>

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" switch between current and last buffer
nmap <leader>. <c-^>

" quickfix
nmap <leader>qf  <Plug>(coc-fix-current)

" undotree
nmap <leader>ut :UndotreeToggle<cr>

" exit terminal
tnoremap <Esc> <C-\><C-n>

" Window moving
map <silent> <C-h> <Plug>WinMoveLeft
map <silent> <C-j> <Plug>WinMoveDown
map <silent> <C-k> <Plug>WinMoveUp
map <silent> <C-l> <Plug>WinMoveRight
" [ultisnips]
let g:loaded_python_provider = 0
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" ---------------------------------------------------------------
" [coc]

" -- basic
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
set cmdheight=1
" always show signcolumns
set signcolumn=yes

" for jsonc highlight
autocmd FileType json syntax match Comment +\/\/.\+$+

" -- tab
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" -- documentation
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" -- highlight
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>b :TagbarToggle<CR>

" ---------------------------------------------------------------
"  [nerdtree]
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

augroup nerdtree
            autocmd!
            autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
            autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
augroup END
let NERDTreeShowHidden=1

" Toggle NERDTree
function! ToggleNerdTree()
            if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                :NERDTreeFind
            else
                :NERDTreeToggle
            endif
endfunction
let NERDTreeIgnore=['\.o$', '\~$', '\.aux$','\.lof$','\.synctex\.gz$', '\.thm$','\.toc$','\.log$', '\.lot$','^\.git$']
"
" ---------------------------------------------------------------
" [fzf]
let g:fzf_layout = { 'down': '~25%' }

if isdirectory(".git")
" if in a git project, use :GFiles
    nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
else
" otherwise, use :FZF
    nmap <silent> <leader>t :FZF<cr>
endif

nmap <silent> <leader>s :GFiles?<cr>
nmap <silent> <leader>f :Files<cr>

nmap <silent> <leader>r :Buffers<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap<leader>d <plug>(coc-definition)

" ---------------------------------------------------------------
" git
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>
highlight link GitGutterChangeLine DiffText
nmap <silent> gl :GitGutterLineHighlightsToggle<cr>

" startify
" Don't change to directory when selecting a file
let g:startify_files_number = 5
let g:startify_change_to_dir = 0
let g:startify_relative_path = 1
let g:startify_use_env = 1
        " Custom startup list, only show MRU from current directory/project
let g:startify_lists = [
\  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
\  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
\  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
\  { 'type': 'commands',  'header': [ 'Commands' ]       },
\ ]
        let g:startify_commands = [
\   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
\   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
\   { 'in': [ 'Install Plugins', 'PlugInstall' ] },
\   { 'll': [ 'Clean Plugins', 'PlugClean' ] }
\ ]
        let g:startify_bookmarks = [
\ { 'c': '~/.config/nvim/init.vim' },
\ { 'g': '~/.gitconfig' },
\ { 'z': '~/.config/fish/config.fish' }
\ ]
autocmd User Startified setlocal cursorline
nmap <leader>st :Startify<cr>

" [go]
au FileType go nmap <Leader>i <Plug>(go-imports)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" [startify]
let g:startify_custom_header=[
\ "                                         -`",
\ "                                        .o+`",
\ "                                       `ooo/",
\ "                                      `+oooo:",
\ "                                     `+oooooo:",
\ "                                     -+oooooo+:",
\ "                                   `/:-:++oooo+:",
\ "                                  `/++++/+++++++:",
\ "                                 `/++++++++++++++:",
\ "                                `/+++ooooooooooooo/`",
\ "                               ./ooosssso++osssssso+`",
\ "                              .oossssso-````/ossssss+`",
\ "                             -osssssso.      :ssssssso.",
\ "                            :osssssss/        osssso+++.",
\ "                           /ossssssss/        +ssssooo/-",
\ "                         `/ossssso+/:-        -:/+osssso+-",
\ "                        `+sso+:-`                 `.-/+oso:",
\ "                       `++:.                           `-/+/",
\ "                       .`                                   `"]

" [airline]
"extensions
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='iceberg'
"extension settings
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let airline#extensions#coc#warning_symbol = ':'
let airline#extensions#coc#error_symbol = ':'

" [cpp-syntax-highlighting]
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1

" [goyo]
nmap <leader>gy :Goyo<cr>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 'gray'

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" [vimtex]
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-xelatex',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
