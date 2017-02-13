set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'davidhalter/jedi-vim'
"Plugin 'Rip-Rip/clang_complete'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
"Plugin 'Yggdroot/indentLine'
Plugin 'dkprice/vim-easygrep'
"Plugin 'jalcine/cmake.vim'
"Plugin 'vhdirk/vim-cmake'

Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'dhruvasagar/vim-markify'

call vundle#end()
filetype plugin indent on

let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

set number

set incsearch
set hlsearch
set ignorecase

set autoindent

"set textwidth=80
"set colorcolumn=+1

set nobackup
set noswapfile
set nowritebackup

if has('persistent_undo')
	silent !mkdir /tmp/vimbackups > /dev/null 2>&1
	set undodir=/tmp/vimbackups
	set undofile
endif

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

nnoremap <silent> vv <C-w>v<C-w>l
nnoremap <silent> ss <C-w>s<C-w>j
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
" Run this on ~ in order to C-h work on darwin.
" infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" tic $TERM.ti
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l<Paste>

    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

set pastetoggle=<F10>

" Remove trailing spaces
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfunction
autocmd FileType * autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Save cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


map <C-n> :NERDTreeToggle<CR>

let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/bin/python3.5'

set clipboard+=unnamedplus

let g:clang_library_path='/usr/lib'
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_user_options ='-std=c++11 -stdlib=libc++'
let g:clang_debug=1
let g:clang_user_options='|| exit 0'
let g:clang_use_library=1


set tabstop=2
set softtabstop=0 noexpandtab
set shiftwidth=2

set listchars=tab:\┆\.,trail:.,nbsp:.,eol:¬
set list

highlight CursorLineNr cterm=none ctermfg=0 guifg=#0c4f60
highlight NonText cterm=none ctermfg=0 guifg=#0c4f60
highlight SpecialKey cterm=none ctermfg=0 guifg=#0c4f60 ctermbg=8 guibg=#0c4f60

let &makeprg = 'if [ -f Makefile ]; then make; else make -C build; fi'

let g:cmake_build_shared_libs = 1
let g:cmake_set_makeprg = 1
let g:cmake_build_directories = [ "build" ]


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_clang_check_config_file='.clang_complete'
let g:syntastic_cpp_checkers=['clang_check']
let g:syntastic_cpp_clang_check_post_args = ""
"let g:ycm_show_diagnostics_ui = 0
let g:syntastic_python_python_exec = '/path/to/python2.7'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"save session and quit
" map , :mksession! ~/mysession.vim<CR>:qa<CR>
" load session
map ; :source ~/mysession.vim<CR>

"type cn or cp to iterate over errors
map cn <esc>:cn<cr>
map cp <esc>:cp<cr>
hi Search ctermfg=Yellow ctermbg=NONE cterm=bold,underline


function! s:CompareQuickfixEntries(i1, i2)
  if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
    return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
  else
    return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
  endif
endfunction

function! s:SortUniqQFList()
  let sortedList = sort(getqflist(), 's:CompareQuickfixEntries')
  let uniqedList = []
  let last = ''
  for item in sortedList
    let this = bufname(item.bufnr) . "\t" . item.lnum
    if this !=# last
      call add(uniqedList, item)
      let last = this
    endif
  endfor
  call setqflist(uniqedList)
endfunction
autocmd! QuickfixCmdPost * call s:SortUniqQFList()

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

set foldmethod=indent


"cldocs plugin
function DocumentFunction(cur_line)
	if !has('python')
		finish
	endif
	pyfile /home/filipecn/cldocs_gen.py
	exec ":py " "curline = vim.eval(\"a:cur_line\")"
	exec ":py " "document_function(curline)"
endfunction

map , :call DocumentFunction(getline('.'))

        let g:jedi#auto_vim_configuration = 0
        let g:jedi#popup_on_dot = 0
        let g:jedi#popup_select_first = 0
        let g:jedi#completions_enabled = 0
        let g:jedi#completions_command = ""
        let g:jedi#show_call_signatures = "1"

        let g:jedi#goto_assignments_command = "<leader>pa"
        let g:jedi#goto_definitions_command = "<leader>pd"
        let g:jedi#documentation_command = "<leader>pk"
        let g:jedi#usages_command = "<leader>pu"
        let g:jedi#rename_command = "<leader>pr"

