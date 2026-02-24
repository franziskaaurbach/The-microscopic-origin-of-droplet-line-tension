clear;

rho=998;
g=9.81;
sigma=0.055;
beta=0.85;
theta0=40*pi/180;

fp=fopen("data_num_no_microscopic.dat","w");

n2=300;
a_vec=zeros(n2,1);
c_t_vec=zeros(n2,1);

V=1e-20;
i=1;
while V<=1.2e-7
    syms f(theta)
    f=dE_theta(theta0,theta,V,rho,g,sigma);
    theta_sol=vpasolve(f,theta,[0.00000001*pi/180 90.9999999*pi/180]);
    R=(3*V/(pi*(1-cos(theta_sol))^2*(2+cos(theta_sol))))^(1/3);
    r=R*sin(theta_sol);
    a_vec(i)=r;
    c_t_vec(i)=cos(theta_sol);
    i=i+1;
    V=V*1.5;
end
n=i-1;

% numerical derivative
for j=1:n-1
    d=(c_t_vec(j+1)-c_t_vec(j))/(1/a_vec(j+1)-1/a_vec(j));
    tau_vec=-sigma*d;
    fprintf(fp,"%.10f %.30f\n",a_vec(j),tau_vec);
end


fclose(fp);

function dE_theta_val=dE_theta(theta0,theta,V,rho,g,sigma)
t1 = sin(theta);
t2 = pi ^ (0.1e1 / 0.3e1);
t3 = t2 ^ 2;
t5 = 3 ^ (0.1e1 / 0.3e1);
t7 = cos(theta);
t8 = 0.2e1 + t7;
t9 = cos(theta0);
t13 = (-0.1e1 + t7) ^ 2;
t14 = 0.1e1 / t13;
t18 = (0.1e1 / t8 * t14 * V) ^ (0.1e1 / 0.3e1);
t26 = t18 ^ 2;
t32 = t8 ^ 2;
dE_theta_val = t14 / t32 / t8 / t2 * V * t5 / t26 * (-0.2e1 * t18 * (t7 - t9) * t8 * t5 * sigma * t3 + rho * g * V) * t1;
end