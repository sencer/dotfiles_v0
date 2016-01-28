inoremap JK <C-c>"zyy"zpVr=o<CR>
inoremap KJ <C-c>"zyy"zpVr-o<CR>

let g:markdown_folding = 1

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:TOC',
    \ ],
    \ 'sort' : 0,
\ }

function! SetMakePrg(format)
  let &makeprg="panzer % -o %:p:r.".a:format
endfunction

command! -n=+ SMP call SetMakePrg(<f-args>)

if &makeprg == "make"
  SMP html
endif

call prose#setup()
