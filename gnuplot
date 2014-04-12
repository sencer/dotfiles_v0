set macros
set tmargin 0; set bmargin 0; set lmargin 0; set rmargin 0

WXT = "set terminal wxt enhanced dashed persist lw 2 font 'Arial, 10'"
QT = "set terminal qt enhanced dashed persist font 'Arial, 10'"
PDF = "set terminal pdfcairo enhanced dashed transparent lw 3 font 'Arial, 18';\
       set output"
PNG = "set terminal pngcairo enhanced dashed transparent lw 2 font 'Arial, 10';\
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
set linetype 51 lc rgb '#800000' lt 0 pt 1
set linetype 52 lc rgb '#006400' lt 0 pt 1
set linetype 53 lc rgb '#000080' lt 0 pt 1
set linetype 55 lc rgb '#9400d3' lt 0 pt 1
set linetype 54 lc rgb '#ff4500' lt 0 pt 1
set linetype 56 lc rgb '#ffa500' lt 0 pt 1
set linetype 57 lc rgb '#ff0000' lt 0 pt 1
set linetype 58 lc rgb '#00ff00' lt 0 pt 1
set linetype 59 lc rgb  ctex     lt 0 pt 1
set linetype 60 lc rgb  cgri     lt 0 pt 1

set linetype 41 lc rgb '#800000' lt 5 pt 4
set linetype 42 lc rgb '#006400' lt 5 pt 4
set linetype 43 lc rgb '#000080' lt 5 pt 4
set linetype 45 lc rgb '#9400d3' lt 5 pt 4
set linetype 44 lc rgb '#ff4500' lt 5 pt 4
set linetype 46 lc rgb '#ffa500' lt 5 pt 4
set linetype 47 lc rgb '#ff0000' lt 5 pt 4
set linetype 48 lc rgb '#00ff00' lt 5 pt 4
set linetype 49 lc rgb  ctex     lt 5 pt 4
set linetype 50 lc rgb  cgri     lt 5 pt 4

set linetype 31 lc rgb '#800000' lt 4 pt 4
set linetype 32 lc rgb '#006400' lt 4 pt 4
set linetype 33 lc rgb '#000080' lt 4 pt 4
set linetype 35 lc rgb '#9400d3' lt 4 pt 4
set linetype 34 lc rgb '#ff4500' lt 4 pt 4
set linetype 36 lc rgb '#ffa500' lt 4 pt 4
set linetype 37 lc rgb '#ff0000' lt 4 pt 4
set linetype 38 lc rgb '#00ff00' lt 4 pt 4
set linetype 39 lc rgb  ctex     lt 4 pt 4
set linetype 40 lc rgb  cgri     lt 4 pt 4

set linetype 21 lc rgb '#800000' lt 3 pt 4
set linetype 22 lc rgb '#006400' lt 3 pt 4
set linetype 23 lc rgb '#000080' lt 3 pt 4
set linetype 25 lc rgb '#9400d3' lt 3 pt 4
set linetype 24 lc rgb '#ff4500' lt 3 pt 4
set linetype 26 lc rgb '#ffa500' lt 3 pt 4
set linetype 27 lc rgb '#ff0000' lt 3 pt 4
set linetype 28 lc rgb '#00ff00' lt 3 pt 4
set linetype 29 lc rgb  ctex     lt 3 pt 4
set linetype 30 lc rgb  cgri     lt 3 pt 4

set linetype 11 lc rgb '#800000' lt 2 pt 12
set linetype 12 lc rgb '#006400' lt 2 pt 12
set linetype 13 lc rgb '#000080' lt 2 pt 12
set linetype 15 lc rgb '#9400d3' lt 2 pt 12
set linetype 14 lc rgb '#ff4500' lt 2 pt 12
set linetype 16 lc rgb '#ffa500' lt 2 pt 12
set linetype 17 lc rgb '#ff0000' lt 2 pt 12
set linetype 18 lc rgb '#00ff00' lt 2 pt 12
set linetype 19 lc rgb  ctex     lt 2 pt 12
set linetype 20 lc rgb  cgri     lt 2 pt 12

set linetype 1 lc rgb '#800000' lt 1 pt 6
set linetype 2 lc rgb '#006400' lt 1 pt 6
set linetype 3 lc rgb '#000080' lt 1 pt 6
set linetype 5 lc rgb '#9400d3' lt 1 pt 6
set linetype 4 lc rgb '#ff4500' lt 1 pt 6
set linetype 6 lc rgb '#ffa500' lt 1 pt 6
set linetype 7 lc rgb '#ff0000' lt 1 pt 6
set linetype 8 lc rgb '#00ff00' lt 1 pt 6
set linetype 9 lc rgb  ctex     lt 1 pt 6
set linetype 10 lc rgb cgri     lt 1 pt 6

set border 3 back lc rgb cgri lw 0.5
set grid back lc rgb cgri lw 0.5 lt 0
set tics nomirror scale 0.5 tc rgb cgri out font ", 16"

unset x2tics
unset y2tics
unset key

set xlabel "X Label" @CTEX
set ylabel "Y Label" @CTEX
set label @CTEX

set style arrow 1 nohead ls 9 lw 0.5 front
set style arrow 2 nohead ls 10 lw 0.5 front
set style arrow 3 heads size scr 0.01, 15, 45 filled ls 9 lw 0.5 front
set style arrow 4 heads size scr 0.01, 15, 45 filled ls 10 lw 0.5 front
set style textbox opaque noborder
set pointintervalbox 2
set pointsize 0.4
