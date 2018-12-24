"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.config/nvim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.config/nvim')
    call dein#begin('$HOME/.config/nvim')

    " Let dein manage dein
    " Required:
    call dein#add('$HOME/.config/nvim/repos/github.com/Shougo/dein.vim')

    " Editing stuff
    call dein#add('tpope/vim-fugitive')  " Git wrapper
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-commentary') " comment individual lines or blocks of lines

    call dein#add('Shougo/deoplete.nvim')
    call dein#add('vim-scripts/a.vim')
    call dein#add('Yggdroot/indentLine')
    call dein#add('jiangmiao/auto-pairs')

    call dein#add('donRaphaco/neotex', { 'for': 'tex' }) " Live LaTeX preview

    " call dein#add('rakr/vim-one')
    " call dein#add('justinmk/vim-syntax-extra')
    " call dein#add('arakashic/chromatica.nvim')

    " Syntax highlighting
    call dein#add('octol/vim-cpp-enhanced-highlight')
    call dein#add('pangloss/vim-javascript')
    call dein#add('vim-python/python-syntax')

    " Visual stuff
    call dein#add('vim-airline/vim-airline')
    call dein#add('rafi/awesome-vim-colorschemes')


    " You can specify revision/branch/tag.
    " call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax on

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

"End dein Scripts-------------------------

" -------- Plugin Settings ---------

" NeoTex settings
" Compile current buffer: :NeoTex
" Turn on NeoTex for current buffer: :NeoTexOn
let g:tex_flavor = 'latex'

" deoplete settings
let g:deoplete#enable_at_startup = 1

" Enhanced cpp highlighting settings
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

" Chromatica settings
"let g:chromatica#enable_at_startup=1
"let g:chromatica#responsive_mode=1 " Chromatica highlight even in insert mode
"let g:chromatica#libclang_path='/usr/lib/x86_64-linux-gnu/libclang-6.0.so.1'

" python syntax highlighting settings
let g:python_highlight_all = 1

set number relativenumber
set splitbelow "open horizontal split on bottom
set splitright "open vertical split on right

set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces

set scrolloff=2 " keep 2 lines visible while scrolling

" Set Airline theme
"let g:airline_theme='molokayo'


" --------- General Settings ---------

colorscheme dracula
"set background=dark " dark version


if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif
