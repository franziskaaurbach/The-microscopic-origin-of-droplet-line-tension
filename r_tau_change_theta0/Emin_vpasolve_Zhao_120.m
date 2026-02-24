clear;

rho=998;
l=5e-9;
g=9.81;
sigma=0.055;
theta0=120*pi/180;

digits(100);
n2=600;
a_vec=zeros(n2,1);
c_t_vec=zeros(n2,1);
tau_direct=zeros(n2,1);
V_vec=zeros(n2,1);
Bo_vec=zeros(n2,1);

V=1e-28;
i=1;
while V<=1.2e-7
    R0=(3*V/(4*pi))^(1/3);
    Bo=rho*g*R0^2/sigma;
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

fp2=fopen("data_num_120.dat","w");

% numerical derivative
for j=1:n-1
    d=(c_t_vec(j+1)-c_t_vec(j))/(1/a_vec(j+1)-1/a_vec(j));
    tau_vec(j)=-sigma*d;
    fprintf(fp2,"%.10f %.30f\n",a_vec(j),tau_vec(j));
end


fclose(fp2);



function dE_theta_val=dE_theta(theta0,sigma,theta,V,g,rho,l)
t1 = cos(theta);
t2 = 0.2e1 + t1;
t6 = (-0.1e1 + t1) ^ 2;
t7 = 0.1e1 / t6;
t9 = (t7 / t2 * V) ^ (0.1e1 / 0.3e1);
t10 = t9 ^ 2;
t12 = pi ^ (0.1e1 / 0.3e1);
t15 = t12 ^ 2;
t17 = 3 ^ (0.1e1 / 0.3e1);
t19 = cos(theta0);
t25 = t1 ^ 2;
t28 = l * sigma;
t45 = sin(theta);
t47 = t2 ^ 2;
dE_theta_val = 0.1e1 / t47 / t2 * t7 * t17 * t45 * (-0.2e1 * t9 * (t1 - t19) * t2 * t17 * sigma * t15 - 0.2e1 * t28 * t25 * t1 * pi - 0.8e1 * t28 * t25 * pi - 0.6e1 * t28 * t1 * pi + rho * g * V + 0.4e1 * pi * l * sigma) * V / t12 / t10;
end

