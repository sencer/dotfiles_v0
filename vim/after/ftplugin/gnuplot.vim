" function! GnuplotInit()
" python << EOF
" try:
"   import Gnuplot
"   gnuplot = Gnuplot.Gnuplot()
"   vim.command('au BufUnload <buffer> :py gnuplot("exit")')
"   vim.command('nnoremap <silent> <buffer> <Space> :.pydo gnuplot(line + "; replot")<CR>')
"   vim.command('vnoremap <silent> <buffer> <Space> :pydo gnuplot(line + "; replot")<CR>')
" except:
"   pass
" EOF
" endfunction

" call GnuplotInit()
