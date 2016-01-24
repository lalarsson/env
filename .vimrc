let g:python_host_prog = '/usr/local/bin/python'
" turn on syntax highlighting
syntax on
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
" and show line numbers
set autoread
set number
set ruler
" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" reload files changed outside vim
set autoread
" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

set scrolloff=3

" indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent
set shiftwidth=4
set softtabstop=4

" no lines longer than 80 cols
set textwidth=80

let &runtimepath.=',$HOME/.vim/bundle/Vundle.vim'
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" start plugin defintion
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'itchyny/lightline.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'Valloric/YouCompleteMe'

" -- Web Development
Plugin 'scrooloose/syntastic'
" -- Other
Plugin 'honza/vim-snippets'
Plugin 'rust-lang/rust.vim'
Plugin 'derekwyatt/vim-scala'
" -- Docker related
Plugin 'ekalinin/Dockerfile.vim'

"-- Other
Plugin 'tpope/vim-markdown'

" end plugin definition
call vundle#end()            " required for vundle
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 0
" start NERDTree on start-up and focus active window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" map FuzzyFinder
noremap <leader>b :FufBuffer<cr>
noremap <leader>f :FufFile<cr>

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" vim-indent-guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" set the color theme to wombat256
colorscheme wombat256
" make a mark for column 80
set colorcolumn=80
" and set the mark color to DarkSlateGray
highlight ColorColumn ctermbg=lightgray guibg=lightgray
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

" synctastic settings"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_signs = 1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]" Binary paths "
let g:syntastic_python_python_exec = '/usr/local/bin/python'
let g:syntastic_java_javac_executable = '/usr/bin/javac'
let g:syntastic_html_tidy_exec = '/usr/local/bin/tidy'
" Checkers "
let g:syntastic_html_checkers = ['jshint','tidy']
let g:syntastic_python_checkers = ['python','pep8']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_java_checkers = ['javac']
let g:syntastic_markdown_checkers = ['mdl']
let g:syntastic_yaml_checkers = ['jsyaml']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_dockerfile_checkers = ['dockerfile_lint']

" other "
au FileType scss setl sw=2 sts=2 et
set backspace=indent,eol,start
nnoremap <F12>q :tabprevious<CR>
nnoremap <F12>w :tabnext<CR>
