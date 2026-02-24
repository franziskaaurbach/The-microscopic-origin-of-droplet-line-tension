#!/usr/bin/gnuplot

reset
set terminal postscript color eps enhanced font "Helvetica, 25" lw 3
set encoding iso_8859_1
set output 'r_tau_ngm.eps'
set size 1,1


set multiplot


TOP    = 0.90
BOTTOM = 0.20     


H      = (TOP - BOTTOM) / 2.0
H1 = 0.4211
H2 = 0.1789
GAP=0.02

set label "(B)" at screen 0,0.97

set tmargin at screen TOP
set bmargin at screen (BOTTOM + H2+0.02)
set lmargin at screen 0.20
set rmargin at screen 0.90
set xrange [1e-9:3e-3]
set yrange [2e-13:1e-4]
set logscale x
set logscale y
set ylabel "{/Symbol t}_{app}, [N]"
set ytics ("10^{-4}" 1e-04, "10^{-6}" 1e-06, "10^{-8}" 1e-08, "10^{-10}" 1e-10, "10^{-12}" 1e-12)

unset xlabel
set format x ""
set key Left reverse left #at screen 0.87,0.735 width 4 #spacing 1


plot "data_num_no_gravity.dat" u ($1):(1)*($2) w l lw 3 dt "-" lc "gray50" title "pressure (single effect)",\
     "data_num_no_microscopic.dat" u ($1):(1)*($2) w l lw 3 dt 3 lc "gray" title "gravity (single effect)",\
     "data_num.dat" u ($1):(1)*($2) w l lw 3 lc "magenta" title "micro-Cassie-Baxter",\
     "data_num2_no_gravity.dat" u ($1):(1)*($2) w l lw 3 dt "-" lc "gray50" title "",\
     "data_num2.dat" u ($1):(1)*($2) w l lw 3 lc rgb "web-blue" title "micro-Wenzel"
     




set tmargin at screen (BOTTOM + H2-0.02)
set bmargin at screen BOTTOM
set lmargin at screen 0.20
set rmargin at screen 0.90
set xrange [1e-9:3e-3]
set yrange [1e-9:2e-13]

set format x "10^{%L}"
set xlabel "r, [m]"
set ylabel "-{/Symbol t}_{app}, [N]"
unset key
unset label


plot "data_num_no_gravity.dat" u ($1):(-1)*($2) w l lw 3 dt "_" lc "gray50",\
     "data_num_no_microscopic.dat" u ($1):(-1)*($2) w l lw 3 dt 5 lc "gray",\
     "data_num.dat" u ($1):(-1)*($2) w l lw 3 lc "magenta",\
     "data_num2_no_gravity.dat" u ($1):(-1)*($2) w l lw 3 dt "-" lc "gray50",\
     "data_num2.dat" u ($1):(-1)*($2) w l lw 3 lc rgb "web-blue"
     

unset multiplot


