#!/usr/bin/gnuplot

#plot 3D image
reset
reset session

reset
set terminal postscript color eps  enhanced font "Helvetica, 25" lw 2
set encoding iso_8859_1
set output sprintf("%s",'theta_tau.eps')

set xlabel "{/Symbol q}, [{\260}]"
set ylabel "{/Symbol t}, [10^{-10}N]"


set key outside right Left reverse
set size 1.5,1


set xrange [0:180]
set yrange [-5:5]

set xtics 30
set ytics 2

plot 0 w l lc "gray" title "",\
	sprintf("%s",'tau.dat') u ($1)*180/pi:($2)/1e-10 w l lc rgb "#009e73" lw 2 title "micro-Cassie-Baxter",\
	sprintf("%s",'tau2.dat') u ($1)*180/pi:($2)/1e-10 w l lw 2 lc "dark-magenta" title "micro-Wenzel",\
	sprintf('Zhao_data.dat') using 1:2:($1-$3):($1+$3):4:5 with xyerrorbars lc "royalblue" ps 2 lw 1.5 title "Zhao 2019",\
	[0:90] -0.055*x+2.37 dt 2 lw 2 lc "royalblue" title "",\
	sprintf('Pompe.dat') using 1:2:($1-$3):($1+$3):4:5 with xyerrorbars lw 1.5 lc "orange" ps 2 title "Pompe 2002",\
	sprintf('Heim.dat') using 2:($1)/1e-10 with points lc "green" ps 2 pt 7 title "Heim 2013",\
	sprintf('Munz.dat') using 2:($1)/1e-10 with points lc "orange-red" ps 2 pt 7 title "Munz 2014",\
	sprintf('Zhang_2008.dat') using 2:($1)/1e-10 with points lc "dark-violet" ps 2 pt 7 title "Zhang 2008",\
	sprintf('Werder.dat') using 2:($1)/1e-10 with points lc "web-green" ps 2 pt 7 title "Werder 2003",\
	sprintf('Wloch.dat') using 2:($1)/1e-10 with points lc "cyan" ps 2 pt 7 title "Wloch 2017",\
	sprintf('Berg.dat') using 2:($1)/1e-10 with points lc "olive" ps 2 pt 7 title "Berg 2010",\
	sprintf('Zhang_2018.dat') using 2:($1)/1e-10 with points lc "violet" ps 2 pt 7 title "Zhang 2018"


