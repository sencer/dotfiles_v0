" GNUPlot Embedding: {{{1
" ==============

if exists("b:current_syntax")
  unlet b:current_syntax
endif

syn include @GNUPlot syntax/gnuplot.vim
syn region GNUPlotEmbedded matchgroup=GNUPlot keepend start="\<cat.*EOF.*gnuplot\>" skip="\\$" end="EOF" contains=@GNUPlot
