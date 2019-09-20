syntax on
colorscheme gruvbox
set background=dark
" set conceallevel=0

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
nnoremap <leader>t :call ToggleNetrw() <CR>

function! ToggleNetrw()
let i = bufnr("$")
    let wasOpen = 0
    while (i >= 1)
        if (getbufvar(i, "&filetype") == "netrw")
            silent exe "bwipeout " . i
            let wasOpen = 1
        endif
        let i-=1
    endwhile
    if !wasOpen
        silent Lexplore
    endif
endfunction

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

