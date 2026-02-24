clear;

rho=998;
l=5e-9;
g=9.81;
sigma=0.055;

digits(100);
theta0=40*pi/180;

n2=400;
a_vec=zeros(n2,1);
c_t_vec=zeros(n2,1);

V=1e-32;
i=1;
while V<=1.2e-7
    syms f(theta)
    f=dE_theta(theta0,sigma,theta,V,g,rho,l);
    thetamin=vpasolve(f,theta,[0.00000001*pi/180 179.9999999*pi/180]);
    R=(3*V/(pi*(1-cos(thetamin))^2*(2+cos(thetamin))))^(1/3);
    r2=R*sin(thetamin);
    a_vec(i)=r2;
    c_t_vec(i)=cos(thetamin);

    V=V*1.5;
    i=i+1;
end
n=i-1;

tau_vec=zeros(n-1,1);

fp2=fopen("data_num2_40.dat","w");

% numerical derivative
for j=1:n-1
    d=(c_t_vec(j+1)-c_t_vec(j))/(1/a_vec(j+1)-1/a_vec(j));
    tau_vec(j)=-sigma*d;
    fprintf(fp2,"%.10f %.30f\n",a_vec(j),tau_vec(j));
end



fclose(fp2);

function dE_theta_val=dE_theta(theta0,sigma,theta,V,g,rho,l)
t1 = sin(theta);
t3 = pi ^ (0.1e1 / 0.3e1);
t4 = t3 ^ 2;
t6 = 3 ^ (0.1e1 / 0.3e1);
t8 = cos(theta);
t9 = 0.2e1 + t8;
t10 = cos(theta0);
t14 = (-0.1e1 + t8) ^ 2;
t15 = 0.1e1 / t14;
t19 = (0.1e1 / t9 * t15 * V) ^ (0.1e1 / 0.3e1);
t23 = t8 ^ 2;
t26 = l * sigma;
t44 = t19 ^ 2;
t47 = t9 ^ 2;
dE_theta_val = t15 / t47 / t9 * t6 / t44 / t3 * (-0.2e1 * t19 * (t8 - t10) * t9 * t6 * sigma * t4 + 0.2e1 * t26 * pi * t23 * t8 + 0.8e1 * t26 * pi * t23 + 0.6e1 * t26 * pi * t8 + rho * g * V - 0.4e1 * pi * l * sigma) * V * t1;
end
