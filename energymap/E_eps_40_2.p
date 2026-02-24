#!/usr/bin/gnuplot

#plot 3D image
reset
reset session


reset
set terminal postscript color eps  enhanced font "Helvetica, 25" lw 2
set output sprintf("%s",'eps_E_40_2.eps')
set mxtics
set mytics
set tics scale 2
set xlabel "{/Symbol f}_{/=16 L1}"
set ylabel "{/Symbol f}_{/=16 L2}" 

set palette defined  (0 0.2 0.5 0.6, 0.5 0.0 0.7 0.7, 0.8 0 0.8 0.9, 1.2 0.5 0.9 0.7, 1.37 1 1 0.5, 1.39 0.7 0.5 0.3, 1.4 0.8 0.5 0.4)




set label "(A)" at screen 0,0.97

set size 1,1

unset key
unset sur
set view map
set label "E/({/Symbol s}{/Symbol p}R_0^2)" at 0.15, 1.08
set xrange [0:1]
set yrange [0:1]
set contour 


FILE = "min.dat"


getValue(row,col,filename) = system('awk ''{if (NR == '.row.') print $'.col.'}'' '.filename.'')


set cbrange [getValue(1,1,sprintf("%s",'data_minmax_40.dat')):getValue(2,1,sprintf("%s",'data_minmax_40.dat'))]


set pm3d at b
set format cb "%.1f"

r=(getValue(2,1,sprintf("%s",'data_minmax_40.dat'))-getValue(1,1,sprintf("%s",'data_minmax_40.dat')))*0.9/3

set cbtics r offset 0,2

num_min = getValue(1,1,sprintf("%s",'data_min_40.dat'))
do for [k=2:num_min+1] {
	set label "" at getValue(k,1,sprintf("%s",'data_min_40.dat')),getValue(k,2,sprintf("%s",'data_min_40.dat')) front point pointtype 2 pointsize 4 lw 2
}


set colorbox horizontal user origin 0.685, 0.92 size 0.2, 0.02
set tmargin at screen 0.9
set bmargin at screen 0.2
set lmargin at screen 0.2
set rmargin at screen 0.9


set cntrparam levels 10
set linetype 1 lc rgb "black"  dt 2
set linetype 2 lc rgb "black"  dt 2
set linetype 3 lc rgb "black"  dt 2
set linetype 4 lc rgb "black"  dt 2 
set linetype 5 lc rgb "black"  dt 2
set linetype 6 lc rgb "black"  dt 2
set linetype 7 lc rgb "black"  dt 2
set linetype 8 lc rgb "black"  dt 2
set linetype 9 lc rgb "black"  dt 2
set linetype 10 lc rgb "black"  dt 2




splot sprintf("%s",'data_40.dat') u 1:2:3  w l lw 1 
system(sprintf("%s",'epstopdf eps_E_40_2.eps'))

