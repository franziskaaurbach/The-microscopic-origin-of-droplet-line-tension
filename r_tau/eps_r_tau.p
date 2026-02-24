#!/usr/bin/gnuplot

#plot 3D image
reset
reset session

reset
set terminal postscript color eps  enhanced font "Helvetica, 25" lw 2
set encoding iso_8859_1
set output sprintf("%s",'r_tau.eps')

set xlabel "r, [m]"
set ylabel "{/Symbol t}_{app}, [N]"


set key outside Left reverse
set size 2.3,1


set xrange [1e-9:3e-3]
set yrange [-1e-9:1e-5]


symlog(y)  = (-1e-14 < y && y < 1e-14) ? y \
           : (y < 0) ? -log10(-y)-14  \
           : log10(y) +14
invsymlog(y) = (-1e-14 < y && y < 1e-14) ? y \
             : (y < -1e-14) ? -10**(-(y+14+1e-14)) \
             : 10**(y-14-1e-14)

             
set nonlinear y via symlog(y) inv invsymlog(y)             

set logscale x

set label "{/Symbol q}_0, [{\260}]" at graph 1.88, 0.07
set colorbox horizontal
set colorbox user origin graph 1.7, -0.03 size 0.4, graph 0.04
set cbrange [0:180]

set cbtics 45

set format x "10^{%L}"
set format y "10^{%L}"


set ytics ("10^{-6}" 1e-06, "10^{-8}" 1e-08, "10^{-10}" 1e-10, "10^{-12}" 1e-12,  "-10^{-6}" -1e-06, "-10^{-8}" -1e-08, "-10^{-10}" -1e-10, "-10^{-12}" -1e-12, "0" 0)


pointsi=2

plot 	'data_num.dat'  u ($1):($2) w l lw 2 lc "black" title "micro-Cassie-Baxter",\
	'data_num2.dat' u ($1):($2) w l lw 2 lc "black" dt 5 title "micro-Wenzel",\
	'zhao_21.dat'        u 1:2:3 		w p pt 3 ps pointsi palette title "Zhao 2019, {/Symbol q}_0=21{\260}", \
	'zhao_85.dat'        u 1:2:3 		w p pt 3 ps pointsi palette title "Zhao 2019, {/Symbol q}_0=85{\260}", \
     	'mugele_all.dat'     u 1:2:3            w p pt 4 ps pointsi palette title "Mugele 2002", \
     	'gaydos.dat'         u 1:2:3            w p pt 6 ps pointsi palette title "Gaydos 1987", \
     	'duncan.dat'         u 1:2:3            w p pt 7 ps pointsi palette title "Duncan 1995", \
     	'wallace.dat'        u 1:2:3         	w p pt 8 ps pointsi palette title "Wallace 1988", \
     	'munz.dat'           u 1:2:3         	w p pt 10 ps pointsi palette title "Munz 2014", \
     	'zhang2019.dat'      u 1:2:3            w p pt 12 ps pointsi palette title "Zhang 2018", \
     	'zhang2008.dat'      u 1:2:3            w p pt 11 ps pointsi palette title "Zhang 2008", \
     	'berg.dat'           u 1:2:3            w p pt 13 ps pointsi palette title "Berg 2010", \
     	'heim.dat'           u 1:2:3            w p pt 14 ps pointsi palette title "Heim 2013", \
     	'checco.dat'         u 1:2:3            w p pt 15 ps pointsi palette title "Checco 2003", \
     	'seemann.dat'        u 1:2:3            w p pt 16 ps pointsi palette title "Seemann 2001", \
     	'kanduc_26.dat'      u 1:2:3            w p pt 17 ps pointsi palette title "Kanduc 2018, {/Symbol q}_0=26{\260}", \
     	'kanduc_137.dat'     u 1:2:3            w p pt 17 ps pointsi palette title "Kanduc 2018, {/Symbol q}_0=137{\260}", \
     	'amirfazli.dat'      u 1:2:3            w p pt 18 ps pointsi palette title "Amirfazli 1998", \
     	'amirfazli_2003.dat'      u 1:2:3            w p pt 18 ps pointsi palette title "Amirfazli 2003", \
     	'wloch_23.dat'       u 1:2:3            w p pt 19 ps pointsi palette title "Wloch 2017, {/Symbol q}_0=23{\260}", \
     	'wloch_123.dat'      u 1:2:3            w p pt 19 ps pointsi palette title "Wloch 2017, {/Symbol q}_0=123{\260}", \
     	'khalkhali.dat'      u 1:2:3            w p pt 20 ps pointsi palette title "Khalkhali 2017", \
     	'drelich_18.dat'     u 1:2:3            w p pt 21 ps pointsi palette title "Drelich 1994, {/Symbol q}_0=8{\260}", \
     	'drelich_90.dat'     u 1:2:3            w p pt 21 ps pointsi palette title "Drelich 1994, {/Symbol q}_0=90{\260}", \
     	'werder_77.dat'      u 1:2:3            w p pt 5 ps pointsi palette title "Werder 2003, {/Symbol q}_0=77{\260}", \
     	'werder_135.dat'     u 1:2:3            w p pt 5 ps pointsi palette title "Werder 2003, {/Symbol q}_0=135{\260}", \
     	'scocchi.dat'        u 1:2:3            w p pt 22 ps pointsi palette title "Scocchi 2011",\
     	'dussaud.dat'         u 1:2:3            w p pt 23 ps pointsi palette title "Dussaud 1997",\
     	'Shintaku.dat'         u 1:2:3            w p pt 23 ps pointsi palette title "Shintaku 2024"



