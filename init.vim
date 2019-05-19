call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-fugitive'      " Git wrapper
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'    " comment individual lines or blocks of lines

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'vim-scripts/a.vim'
    Plug 'jiangmiao/auto-pairs'

    Plug 'junegunn/vim-easy-align'

    Plug 'sophacles/vim-processing' " support for Processing language

    " Motion stuff
    Plug 'bkad/CamelCaseMotion'

    " Searching
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Syntax highlighting
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'pangloss/vim-javascript'
    Plug 'vim-python/python-syntax'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'leshill/vim-json'
    Plug 'PProvost/vim-ps1'


    " Visual stuff
    Plug 'vim-airline/vim-airline'
    Plug 'Yggdroot/indentLine'
    "Plug 'nathanaelkane/vim-indent-guides'

    "Plug 'donRaphaco/neotex', { 'for': 'tex' }) " Live LaTeX preview

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
" nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


" Remove leftover highlighting
nnoremap <silent> <Leader>n :noh<CR>


" Open files in vertical horizontal split
" nnoremap <silent> <Leader>v :call fzf#run({
" \   'right': winwidth('.') / 2,
" \   'sink':  'vertical botright split' })<CR>


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

" Indent Guides settings
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_guide_size = 1
" let g:indent_guides_start_level = 2

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




" ---------- FZF stuff ------------

" function! s:find_git_root()
"   return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
" endfunction

" command! ProjectFiles execute 'Files' s:find_git_root()

" noremap <leader>f :ProjectFiles<cr>

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
