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

" Colorscheme
syntax on
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
