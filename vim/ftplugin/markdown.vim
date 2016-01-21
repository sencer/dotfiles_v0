inoremap JK <C-c>"zyy"zpVr=o<CR>
inoremap KJ <C-c>"zyy"zpVr-o<CR>

let g:markdown_folding = 1

set makeprg=markdown\ \<\ %\ \>\ %:r.html

call prose#setup()
