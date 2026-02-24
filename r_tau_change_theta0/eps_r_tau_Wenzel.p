#!/usr/bin/gnuplot

#plot 3D image
reset
reset session

reset
set terminal postscript color eps  enhanced font "Helvetica, 25" lw 2
set encoding iso_8859_1
set output sprintf("%s",'r_tau_Wenzel.eps')

set xlabel "r, [m]"
set ylabel "{/Symbol t}_{app}, [N]"

set tmargin at screen 0.9
set bmargin at screen 0.2
set lmargin at screen 0.2
set rmargin at screen 0.9

set key inside left Left reverse maxrows 3 
set key at 1e-8,2e-5
set size 1,1


set label "micro-Wenzel" at 5e-8,2e-8


set label "(ii)" at screen 0.05,0.97

set xrange [1e-8:3e-3]
set yrange [-1e-9:1e-4]

l=12
l2=1e-12

symlog(y)  = (-l2 < y && y < l2) ? y \
           : (y < 0) ? -log10(-y)-l  \
           : log10(y) +l
invsymlog(y) = (-l2 < y && y < l2) ? y \
             : (y < -l2) ? -10**(-(y+l+l2)) \
             : 10**(y-l-l2)

             
set nonlinear y via symlog(y) inv invsymlog(y)             

set logscale x

set format x "10^{%L}"
set format y "10^{%L}"



set ytics ("10^{-4}" 1e-04,"10^{-6}" 1e-06, "10^{-8}" 1e-08, "10^{-10}" 1e-10,   "-10^{-8}" -1e-08,  "-10^{-10}" -1e-10, "0" 0)


pointsi=2

plot 	'data_num2_40.dat' u ($1):($2) w l lw 3 lc rgb "web-green"  title "{/Symbol q}_0=40{\260}",\
	'data_num2_120.dat' u ($1):($2) w l lw 3 lc "web-blue"  title "{/Symbol q}_0=120{\260}"



