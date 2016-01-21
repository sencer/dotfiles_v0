inoremap JK <C-c>"zyy"zpVr=o<CR>
inoremap KJ <C-c>"zyy"zpVr-o<CR>

let g:markdown_folding = 1

function! SetMakePrg(arg)
  let &makeprg="pandoc -f markdown -t ".a:arg." % -o %:t:r.".a:arg
endfunction
command! -n=1 SMP call SetMakePrg(<f-args>)
SMP html

call prose#setup()
