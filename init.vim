call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-fugitive'      " Git wrapper
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tomtom/tcomment_vim'

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'vim-scripts/a.vim'
    Plug 'jiangmiao/auto-pairs'

    Plug 'junegunn/vim-easy-align'

    Plug 'tmux-plugins/vim-tmux-focus-events'


    Plug 'vim-scripts/a.vim' " switch between source files and header files quick

    " Motion stuff
    Plug 'bkad/CamelCaseMotion'

    " Searching
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Syntax highlighting
    Plug 'bfrg/vim-cpp-modern'
    Plug 'pangloss/vim-javascript'
    Plug 'vim-python/python-syntax'
    Plug 'leshill/vim-json'
    Plug 'PProvost/vim-ps1'
    Plug 'posva/vim-vue'
    Plug 'mustache/vim-mustache-handlebars'
    Plug 'dracula/vim'

    " Visual stuff
    Plug 'vim-airline/vim-airline'
    Plug 'Yggdroot/indentLine'

" Initialize plugin system
call plug#end()

filetype plugin indent on
syntax on

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
                               "

set title
set autoread " detect when a file is changed

set nolazyredraw " don't redraw while executing macros

set showmatch " show matching braces

set smartindent


" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
au FocusGained * :checktime
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None



let mapleader = ","

color dracula
highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none

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


" Remove leftover highlighting
nnoremap <silent> <Leader>n :noh<CR>



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

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)



" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

nmap <leader>t :call TrimWhitespace()<CR>


" Make default comment // instead of /* */ in C, C++
autocmd FileType c,cpp set commentstring=//\ %s

" Resize splits with arrow keys
" nnoremap <Up> :resize +5<CR>
" nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize +5<CR>
nnoremap <Right> :vertical resize -5<CR>


" ---------- FZF stuff ------------

nmap <leader>f :Files<CR>
nmap <leader>l :Rg<CR>

" fzf-vim
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Type'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Character'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'] }


" To use ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
