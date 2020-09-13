call plug#begin()

    "Default settings"
	Plug 'tpope/vim-sensible'

    "File explorer"   
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

    "UI"
    Plug 'itchyny/lightline.vim'
    Plug 'w0rp/ale'
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'
	Plug 'ayu-theme/ayu-vim'
	Plug 'Yggdroot/indentLine'
    Plug 'ryanoasis/vim-devicons'

	"For remote completion"
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'

	"For the snippets"
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	"You Complete Me"
	Plug 'Valloric/YouCompleteMe'

	"For Git"
	Plug 'airblade/vim-gitgutter'
    Plug 'itchyny/vim-gitbranch'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'

    "For LaTeX"
    Plug 'lervag/vimtex'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'Shougo/unite.vim'
    Plug 'rafaqz/citation.vim'

    "For tags"
    Plug 'majutsushi/tagbar'
    Plug 'ludovicchabant/vim-gutentags'

    "Markdown Preview"
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

" AyuTheme {{
source ~/.vim/plugged/ayu-vim/colors/ayu.vim
set termguicolors
let ayucolor="dark"
" }}

" IndentLine {{
let g:indentLine_char = '┊'
let g:indentLine_first_char = '⋮'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}

"LightLine {{
let g:lightline = {}

let g:lightline.component = {
      \   'lineinfo': ' %3l:%-2v%<',
      \   'percent': '☰ %3p%%',
      \}

let g:lightline.component_function = {
      \  'gitbranch': 'GitBranch',
      \  'filename': 'LightLineFname',
      \}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.separator = {
      \  'left': '',
      \  'right': ''
      \ }

let g:lightline.subseparator = {
      \  'left': '',
      \  'right': ''
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

let g:lightline.active = {
      \     'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \               ['percent', 'lineinfo'],
      \               ['fileformat']],
      \     'left': [[ 'mode', 'paste' ],
      \             [ 'gitbranch', 'filename']]
      \ }

let g:viewplugins = '__Tagbar__\|__Mundo__\|__Mundo_Preview__\|NERD_tree'

function! LightLineFname() 
    let fticon = (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') 
    let filename = LightLineFilename()
    let modified = ModifiedStatus()
    if filename == ''
    return ''
    endif
    return expand('%:t') =~# g:viewplugins ? '' :
    \ join([fticon, filename, modified],'')
endfunction

function! LightLineFilename()
  let readonly = LightLineReadonly()
  return ('' != readonly ? readonly . ' ' : '') .
    \ ('' != expand('%:t') ? expand('%:t') : '')
endfunction

function! LightLineReadonly()
  return &readonly ? '' : ''
endfunction

function! GitBranch()
    return ' '.gitbranch#name()
endfunction
"}}

function! ModifiedStatus()
  let modified = LightLineModified()
  return ('' != modified ? ' ' . modified : '')
endfunction

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '' : &modifiable ? '' : '-'
endfunction

"Ale lynters config {{
let g:ale_pattern_options = {
      \ '\.py$': {'ale_linters': ['flake8', 'pylint'], 'ale_fixers': ['autopep8', 'yapf']},
\}
"}}

let g:tex_flavor = 'latex'
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'latexmk'

"Zotero {{
let g:citation_vim_mode="zotero"
let g:citation_vim_zotero_path="~/Zotero"
let g:citation_vim_zotero_version=5
let g:citation_vim_cache_path='~/.vim/cache'
let g:citation_vim_outer_prefix="["
let g:citation_vim_inner_prefix="@"
let g:citation_vim_suffix="]"
let g:citation_vim_et_al_limit=2
"}}


let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = '/usr/bin/python3'

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"


set encoding=UTF-8
set hlsearch
set nu
set hidden
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set backspace=indent,eol,start
set wildmenu
set wildmode=longest:full,full

nmap <F6> :NERDTreeToggle<CR>
nmap <F7> :TagbarToggle<CR>
nmap <leader>u [unite]
nnoremap [unite] <nop>

" Citations Config {
nnoremap <silent>[unite]c :<C-u>Unite -buffer-name=citation-start-insert -default-action=append citation/key<cr>
nnoremap <silent>[unite]co :<C-u>Unite -input=<C-R><C-W> -default-action=start -force-immediately citation/file<cr>
nnoremap <silent><leader>cu :<C-u>Unite -input=<C-R><C-W> -default-action=start -force-immediately citation/url<cr>
nnoremap <silent>[unite]cf :<C-u>Unite -input=<C-R><C-W> -default-action=file -force-immediately citation/file<cr>
nnoremap <silent>[unite]ci :<C-u>Unite -input=<C-R><C-W> -default-action=preview -force-immediately citation/combined<cr>
nnoremap <silent>[unite]cp :<C-u>Unite -default-action=yank citation/your_source_here<cr>
nnoremap <silent><leader>cn :<C-u>UniteWithCursorWord -default-action=yank -force-immediately citation/title<cr><cr>:!zotcli add-note "<C-R>0"<cr>
nnoremap <silent>[unite]cs :<C-u>Unite  -default-action=yank  citation/key:<C-R><C-W><cr>
vnoremap <silent>[unite]cs :<C-u>exec "Unite  -default-action=start citation/key:" . escape(@*,' ') <cr>
nnoremap <silent>[unite]cx :<C-u>exec "Unite  -default-action=start citation/key:" . escape(input('Search Key : '),' ') <cr>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nnoremap <silent><buffer><expr> <C-o> unite#do_action('start')
  imap     <silent><buffer><expr> <C-o> unite#do_action('start')
  nnoremap <silent><buffer><expr> <C-i> unite#do_action('preview')
  imap     <silent><buffer><expr> <C-i> unite#do_action('preview')
endfunction
"}

"Markdown config{
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 1
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
let g:mkdp_page_title = '「${name}」'
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
"}
