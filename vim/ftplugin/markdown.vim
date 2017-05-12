inoremap JK <C-c>"zyy"zpVr=o<CR>
inoremap KJ <C-c>"zyy"zpVr-o<CR>

let g:markdown_folding = 1
" let g:markdown_fenced_languages = ['ruby']

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

iabbrev h2 H~2~
iabbrev o2 O~2~
iabbrev h2o H~2~O
iabbrev tio2 TiO~2~
iabbrev TiO2 TiO~2~

augroup fold
  autocmd!
  autocmd InsertEnter <buffer> set foldmethod=manual
  autocmd InsertLeave <buffer> set foldmethod=expr
augroup END


function! s:FindStartingIndex()
  let cur_line = getline('.')
  let start = col('.') - 1

  while start > 0 && cur_line[start-2:start - 1] !~ '[[,;]@'
    let start -= 1
  endwhile

  return start
endfunction

function! ZoteroComplete(findstart, base)
  if a:findstart
    return s:FindStartingIndex()
  endif
  let cmd = 'curl -s "http://localhost:23119/zotxt/search?q='.shellescape(a:base).'&format='
  let keys = eval(substitute(system(cmd.'easykey"'), '\n', '', 'g'))
  let info = eval(substitute(system(cmd.'quickBib"'), '\n', '', 'g'))
  let results = []
  let i = 0
  while i < len(keys)
    let entry = {
          \'word': keys[i],
          \'abbr': info[i]['quickBib'],
          \'menu': info[i]['quickBib'],
          \'icase': 1
          \}
    call add(results, entry)
    let i+=1
  endwhile

  return results
endfunction

setlocal completefunc=ZoteroComplete
