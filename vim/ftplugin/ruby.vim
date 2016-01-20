let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:ruby_indent_access_modifier_style = 'outdent'
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

compiler ruby
let g:VtrInitialCommand = "irb"
nnoremap <Leader>r :VtrSendLinesToRunner!<CR>
vnoremap <Leader>r :VtrSendLinesToRunner!<CR>
