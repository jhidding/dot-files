set cursorline
syntax on
set number
set termguicolors

colorscheme gruvbox-material
set background=dark
set conceallevel=0

" Disable tabs
set expandtab

" Mouse settings
set mouse=a

" File tree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let mapleader = ","
nnoremap <leader>f :NERDTreeToggle <CR>

" Line wrap mode
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

setlocal linebreak
setlocal nolist
setlocal display+=lastline

" Pandoc syntax
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

let g:pandoc#syntax#codeblocks#embeds#langs = ["haskell", "python", "sqlite", "scheme", "cpp", "julia"]
let g:pandoc#syntax#use_definition_lists = 0
