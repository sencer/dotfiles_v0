set macros
set tmargin 0; set bmargin 0; set lmargin 0; set rmargin 0

WXT = "set terminal wxt enhanced dashed lw 2 persist font 'Arial, 10'"
QT = "set terminal qt enhanced dashed persist font 'Arial, 10'"
PDF = "set terminal pdfcairo enhanced dashed transparent lw 2 font 'Arial, 10';\
       set output"
A4L = "set terminal pdfcairo enhanced dashed transparent lw 3 font 'Arial, 14' size 8.5, 11;\
       set output"
A4P = "set terminal pdfcairo enhanced dashed transparent lw 3 font 'Arial, 14' size 11, 8.5;\
       set output"
PNG = "set terminal pngcairo enhanced dashed transparent size 1280,960 lw 1.5 font 'Arial, 18';\
       set output"
PNGT= "set terminal pngcairo enhanced dashed size 1280,960 lw 1.5 font 'Arial, 18';\
       set output"

MP = "set tics mirror in; \
      set format x ''; \
      unset x2tics; \
      unset y2tics; \
      set border 31 back; \
      unset xlabel; \
      unset ylabel;\
      set multiplot "
CLEAN = "unset border; \
         unset tics; \
         unset grid; \
         unset label; \
         unset xlabel; \
         unset ylabel; \
         unset key; \
         unset title"

MATLAB = "set palette defined (0  0.0 0.0 0.5, \
                               1  0.0 0.0 1.0, \
                               2  0.0 0.5 1.0, \
                               3  0.0 1.0 1.0, \
                               4  0.5 1.0 0.5, \
                               5  1.0 1.0 0.0, \
                               6  1.0 0.5 0.0, \
                               7  1.0 0.0 0.0, \
                               8  0.5 0.0 0.0 )"

GB = "set linetype 1  lc rgb '#0025ad' lt 1;\
      set linetype 2  lc rgb '#0042ad' lt 1;\
      set linetype 3  lc rgb '#0060ad' lt 1;\
      set linetype 4  lc rgb '#007cad' lt 1;\
      set linetype 5  lc rgb '#0099ad' lt 1;\
      set linetype 6  lc rgb '#00ada4' lt 1;\
      set linetype 7  lc rgb '#00ad88' lt 1;\
      set linetype 8  lc rgb '#00ad6b' lt 1;\
      set linetype 9  lc rgb '#00ad4e' lt 1;\
      set linetype 10 lc rgb '#00ad31' lt 1;\
      set linetype 11 lc rgb '#00ad14' lt 1;\
      set linetype 12 lc rgb '#09ad00' lt 1"

GBP = "set palette defined (1  '#0025ad', \
                            2  '#0042ad', \
                            3  '#0060ad', \
                            4  '#007cad', \
                            5  '#0099ad', \
                            6  '#00ada4', \
                            7  '#00ad88', \
                            8  '#00ad6b', \
                            9  '#00ad4e', \
                            10 '#00ad31', \
                            11 '#00ad14', \
                            12 '#09ad00' )"

@WXT

nplots = "1 1"
margins = "0.15 0.8 0.15 0.9"
separate = "0 0"
span = "1 1"

put(i,j) = sprintf("\
  width = (1 - word(margins, 1) - word(separate, 2) * (word(nplots, 2) - 1)) / \
    word(nplots, 2);\
  height = (1 - word(margins, 3) - word(separate, 1) * (word(nplots, 1) - 1)) / \
    word(nplots, 1);\
  x_0 = word(margins, 1) * word(margins, 2) + \
    (%d - 1) * (width + word(separate,2));\
  y_0 = word(margins, 3) * word(margins, 4) + \
    (word(nplots, 1) - %d) * (height + word(separate,1));\
  set origin x_0, y_0;\
  set size width * word(span, 2) + word(separate, 2) * (word(span, 2) - 1), \
    height * word(span, 1) + word(separate, 1) * (word(span, 1) - 1)\
  ", j, i)

getCenter(i) = (i == 0) ? \
  (1 - word(margins, 1)) / 2 + word(margins, 1) * word(margins, 2) :\
  (1 - word(margins, 3)) / 2 + word(margins, 3) * word(margins, 4)


eval put(1, 1)

d(x, y) = ($0 == 0) ? (x2 = x, y2 = y, 1/0) :( \
          ($0 == 1) ? (x1 = x, y1 = y, 1/0) :  \
          (dyx = (y-y2)/(x-x2), x2 = x1, y2 = y1, x1 = x, y1 = y, dyx) )
old(x) = ($0 < 2) ? 1/0 : x1

set fit log "/tmp/fit.log"
f(x) = m * x + b

linfit(f, c, d, st, en) = sprintf("\
  fit [%f:%f] f(x) '%s' u %s:%s via m, b\
  ", st, en, f, c, d)

drawLF(st, en, id, opt) = sprintf("\
  set arrow %d from %f, f(%f) to %f, f(%f) %s\
  ", id, st, st, en, en, opt)


ctex = '#404040'
cgri = '#808080'
TEX = "tc rgb ctex"
CTEX = "@TEX center"
LTEX = "@TEX left"
RTEX = "@TEX right"

# set style increment user

set linetype 1 lc rgb '#800000' pt 6
set linetype 2 lc rgb '#006400' pt 6
set linetype 3 lc rgb '#000080' pt 6
set linetype 5 lc rgb '#9400d3' pt 6
set linetype 4 lc rgb '#ff4500' pt 6
set linetype 6 lc rgb '#ffa500' pt 6
set linetype 7 lc rgb '#ff0000' pt 6
set linetype 8 lc rgb '#00ff00' pt 6
set linetype 9 lc rgb  ctex     pt 6
set linetype 10 lc rgb cgri     pt 6
set linetype cycle 11

set border 3 back lc rgb cgri lw 0.5
set grid back lc rgb cgri lw 0.5 lt 0
set tics nomirror scale 0.5 tc rgb cgri out

unset x2tics
unset y2tics
unset key

set xlabel "X Label" @CTEX font ", 12"
set ylabel "Y Label" @CTEX font ", 12"
set label @CTEX

set style arrow 1 nohead ls 9 lw 0.5 front
set style arrow 2 nohead ls 10 lw 0.5 front
set style arrow 3 heads size scr 0.01, 15, 45 filled ls 9 lw 0.5 front
set style arrow 4 heads size scr 0.01, 15, 45 filled ls 10 lw 0.5 front
set style textbox opaque noborder
set pointintervalbox 2
set pointsize 0.4

# vim: filetype=gnuplot
