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
    call dein#add('tpope/vim-fugitive')      " Git wrapper
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-commentary')    " comment individual lines or blocks of lines

    call dein#add('Shougo/deoplete.nvim')
    call dein#add('vim-scripts/a.vim')
    call dein#add('jiangmiao/auto-pairs')


    call dein#add('sophacles/vim-processing') " support for Processing language

    " Motion stuff
    call dein#add('bkad/CamelCaseMotion')

    " Searching
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

    " Syntax highlighting
    call dein#add('octol/vim-cpp-enhanced-highlight')
    call dein#add('pangloss/vim-javascript')
    call dein#add('vim-python/python-syntax')
    call dein#add('rafi/awesome-vim-colorschemes')
    call dein#add('leshill/vim-json')

    " Visual stuff
    call dein#add('vim-airline/vim-airline')
    "call dein#add('Yggdroot/indentLine')
    call dein#add('nathanaelkane/vim-indent-guides')

    call dein#add('donRaphaco/neotex', { 'for': 'tex' }) " Live LaTeX preview

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


" --------- General Settings ---------

set number relativenumber
set splitbelow " open horizontal split on bottom
set splitright " open vertical split on right

set tabstop=4       " show existing tab with 4 spaces width
set shiftwidth=4    " when indenting with '>', use 4 spaces width
set expandtab       " insert spaces when pressing tab
set scrolloff=2     " keep 2 lines visible while scrolling

set ignorecase smartcase       " if search pattern is all lowercase, find all matches.
                               " if pattern contains upperase, find only matches with
                               " uppercase

let mapleader = ","

colorscheme dracula

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

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


" Open files in vertical horizontal split
nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>


" -------- Plugin Settings ---------

" deoplete settings
let g:deoplete#enable_at_startup = 1

" Enhanced cpp highlighting settings
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

" python syntax highlighting settings
let g:python_highlight_all = 1

" CamelCaseMotion settings
call camelcasemotion#CreateMotionMappings('<leader>') " use default mappings

" NeoTex settings
" Compile current buffer: :NeoTex
" Turn on NeoTex for current buffer: :NeoTexOn
let g:tex_flavor = 'latex'

" Indent Guides settings
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2



" ---------- FZF stuff ------------

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

noremap <leader>f :ProjectFiles<cr>

