set exrc

let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e41 q"
let currentMode = mode()
set relativenumber
set nohlsearch
set hidden
set noerrorbells

set pyxversion=3
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.temp/nvim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect

if has("nvim-0.5.0") || has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" use system clipboard
set clipboard+=unnamedplus
" remap ctr + z to u to avoid crashing application 
nnoremap <C-Z> u

" Give more space for displaying messages
set cmdheight=2
set timeoutlen=1000
set ttimeoutlen=0
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set updatetime=100
set shortmess+=c
set cul!

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'gruvbox-community/gruvbox'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" comment toogle
Plug 'tpope/vim-commentary'

" c++ utilities
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'npm install --frozen-lockfile'}
" opening and closing brackets
Plug 'jiangmiao/auto-pairs'

"cpp
call plug#end()

colorscheme gruvbox
highlight Normal guibg=none
highlight LineNr guifg=#16bdc9

let mapleader = " "
" telescope macros
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<CR>

" open previous file
nnoremap <leader>pe :e#<CR>
" open explorer 
nnoremap <leader>ex :Explore<CR>
" open .vim file
nnoremap <Leader>vim :e ~/.config/nvim/init.vim<CR>
" source .vim file
nnoremap <leader>svi :so ~/.config/nvim/init.vim<CR>

"c++ langauge settings
" https://github.com/neoclide/coc.nvim#example-vim-configuration
set encoding=utf-8
set nowritebackup
set fileencodings=utf-8

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use [g and ]g to navigate diagnostics
" Use :CocDiagnostics to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" code spelling utilities
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" insert stuff into quotes
nnoremap <Leader>" ciw""<Esc>P
nnoremap <Leader>' ciw''<Esc>P
nnoremap <Leader>qd daW"=substitute(@@,"'\\\|\"","","g")<CR>P
