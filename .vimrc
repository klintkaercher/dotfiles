"Plugin (vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' " CS
Plug 'arcticicestudio/nord-vim' " CS
Plug 'flrnprz/plastic.vim' " CS
Plug 'flrnd/candid.vim' " CS
Plug 'dylnmc/novum.vim' " CS
Plug 'arzg/vim-colors-xcode' " CS
Plug 'sainnhe/sonokai' " CS

Plug 'tpope/vim-fugitive' " Git
Plug 'tpope/vim-surround' " Surround
Plug 'mbbill/undotree' " Undo history
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc
Plug 'ctrlpvim/ctrlp.vim' " File search
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/DoxygenToolkit.vim' " Doxygen Commenting
"Plug 'ludovicchabant/vim-gutentags' " Doxygen Commenting
Plug 'jremmen/vim-ripgrep'
Plug 'hasufell/ghcup.vim/' " GHCup
Plug 'wellle/context.vim' " function headers

Plug 'elixir-editors/vim-elixir/' " Elixir syntax
Plug 'ziglang/zig.vim' " Zig syntax
Plug 'zah/nim.vim' " Nim syntax
Plug 'udalov/kotlin-vim' " Nim syntax
call plug#end()

" Settings
set noerrorbells
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
set autoindent
set smartindent
set rnu nu
set splitbelow
set splitright
set nowrap
set smartcase
set noswapfile
set nobackup
set colorcolumn=81
set incsearch
set nohlsearch
set scrolloff=8
set guicursor=

" Misc Mappings
let mapleader = " "
inoremap jj <Esc>
nnoremap n nzz
nnoremap N Nzz
nnoremap ; :
nnoremap : ;
vnoremap <leader>c "+y
nnoremap <leader>hl :set hlsearch!<CR>
nnoremap <silent> <leader>sp :set spell!<CR>
nnoremap ci{ f{lct}
nnoremap <leader>st :15sp<CR>:terminal<CR>i
tnoremap jj <C-\><C-N>
nnoremap <leader>dc :CocDisable<CR>
nnoremap <leader>ec :CocEnable<CR>
inoremap ``b <Esc>xxxi```bash<CR>```<Esc>O
nnoremap <leader>da :r!date +\%m/\%d/\%y<CR>

" Tabs
noremap <silent> <leader>th :tabe ./<CR>
noremap <silent> <leader>0 :tabr<CR>
noremap <silent> <leader>1 :tabn 2<CR>
noremap <silent> <leader>2 :tabn 3<CR>
noremap <silent> <leader>3 :tabn 4<CR>
noremap <silent> <leader>4 :tabn 5<CR>
noremap <silent> <leader>9 :tabl<CR>

" .vimrc
noremap <leader>ev :vsplit ~/.vimrc<CR>
noremap <leader>sv :source $MYVIMRC<CR>

" Folds (because split keyboard is weird with hold timings)
vnoremap <C-f> zf

" Splits
noremap <leader>vh :vs ./<CR>
noremap <leader>sh :sp ./<CR>
noremap <C-h> <C-w>h 
noremap <C-j> <C-w>j 
noremap <C-k> <C-w>k 
noremap <C-l> <C-w>l 
nnoremap _ :resize -5<CR>
nnoremap + :resize +5<CR>
nnoremap { :vertical resize -5<CR>
nnoremap } :vertical resize +5<CR>

"NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Colorscheme
syntax on
colorscheme sonokai
"colorscheme peachpuff " useful for outdoor environments

" search on visual selection (not sure how this works)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Relative numbers only in active buffer
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Commenting shortcuts
augroup commenting
    autocmd!
    autocmd FileType asm        noremap cc mq:s@^@;@<CR>`q
    autocmd FileType asm        noremap cu mq:s@^;@@<CR>`q
    autocmd FileType c          noremap cc mq:s@^@//@<CR>`q
    autocmd FileType c          noremap cu mq:s@^//@@<CR>`q
    autocmd FileType clojure    noremap cc mq:s@^@;;@<CR>`q
    autocmd FileType clojure    noremap cu mq:s@^;;@@<CR>`q
    autocmd FileType cmake      noremap cc mq:s@^@#@<CR>`q
    autocmd FileType cmake      noremap cu mq:s@^#@@<CR>`q
    autocmd FileType cpp        noremap cc mq:s@^@//@<CR>`q
    autocmd FileType cpp        noremap cu mq:s@^//@@<CR>`q
    autocmd FileType elixir     noremap cc mq:s@^@#@<CR>`q
    autocmd FileType elixir     noremap cu mq:s@^#@@<CR>`q
    autocmd FileType go         noremap cc mq:s@^@//@<CR>`q
    autocmd FileType go         noremap cu mq:s@^//@@<CR>`q
    autocmd FileType haskell    noremap cc mq:s@^@--@<CR>`q
    autocmd FileType haskell    noremap cu mq:s@^--@@<CR>`q
    autocmd FileType javascript noremap cc mq:s@^@//@<CR>`q
    autocmd FileType javascript noremap cu mq:s@^//@@<CR>`q
    autocmd FileType kotlin     noremap cc mq:s@^@//@<CR>`q
    autocmd FileType kotlin     noremap cu mq:s@^//@@<CR>`q
    autocmd FileType perl       noremap cc mq:s@^@#@<CR>`q
    autocmd FileType perl       noremap cu mq:s@^#@@<CR>`q
    autocmd FileType php        noremap cc mq:s@^@#@<CR>`q
    autocmd FileType php        noremap cu mq:s@^#@@<CR>`q
    autocmd FileType python     noremap cc mq:s@^@#@<CR>`q
    autocmd FileType python     noremap cu mq:s@^#@@<CR>`q
    autocmd FileType rust       noremap cc mq:s@^@//@<CR>`q
    autocmd FileType rust       noremap cu mq:s@^//@@<CR>`q
    autocmd FileType sh         noremap cc mq:s@^@#@<CR>`q
    autocmd FileType sh         noremap cu mq:s@^#@@<CR>`q
    autocmd FileType tex        noremap cc mq:s@^@%@<CR>`q
    autocmd FileType tex        noremap cu mq:s@^%@@<CR>`q
    autocmd FileType lua        noremap cc mq:s@^@--@<CR>`q
    autocmd FileType lua        noremap cu mq:s@^--@@<CR>`q
    autocmd FileType vim        noremap cc mq:s@^@"@<CR>`q
    autocmd FileType vim        noremap cu mq:s@^"@@<CR>`q
    autocmd FileType yaml       noremap cc mq:s@^@#@<CR>`q
    autocmd FileType yaml       noremap cu mq:s@^#@@<CR>`q
    autocmd FileType zig        noremap cc mq:s@^@//@<CR>`q
    autocmd FileType zig        noremap cu mq:s@^\(\s*\)//@\1@<CR>`q

    autocmd FileType markdown   set cc=0
augroup END

" Plugin Specific
if executable('rg')
    let g:rg_derive_root='true'
endif

" Need to escape the pipe character.
nnoremap <leader>u :UndotreeToggle \| UndotreeFocus<CR>
nnoremap <leader>gb :Git blame<CR>




" Some commands to scroll coc output from https://github.com/neoclide/coc.nvim
" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Search workspace symbols
nnoremap <silent><nowait> <space>y  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>w  :<C-u>CocList commands<cr>





let g:ctrlp_working_path_mode = ""
let g:coc_disable_startup_warning = 1
let g:DoxygenToolkit_commentType = "RTK"
let g:gutentags_exclude_project_root = ["/home/klint/"]

" Custom commands that take parameters.
" These aren't really that useful, but show an example of how to make commands
command -nargs=1 SW set shiftwidth=<args>
command -nargs=1 CC set cc=<args>
command WW set wrap linebreak | nnoremap j gj | nnoremap k gk
command EE !pdflatex *.tex
command CNT %s///gn
command TypeA :call TypeA()

function! TypeA()
  :%s/brief/spaghetti/c
endfunction
