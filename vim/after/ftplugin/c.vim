let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_periodic_quickfix=1
" let g:clang_complete_copen=1
let g:clang_close_preview=1
let g:clang_hl_errors=1
let g:clang_use_library=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
let g:clang_library_path='/usr/local/lib'
" let g:clang_user_options='2>/dev/null || exit 0'
let g:clang_snippets=1
let g:clang_snippets_engine='clang_complete'
let g:clang_conceal_snippets=1
set concealcursor=inv conceallevel=3
let g:clang_trailing_placeholder=1
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1
" let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_checkers= ['make', 'gcc']
let g:syntastic_c_compiler_options = '-Wall -pedantic -std=c99 -fopenmp'
