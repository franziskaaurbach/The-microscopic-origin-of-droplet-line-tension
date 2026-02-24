clear;

rho=998;
l=5e-9;
g=9.81;
sigma=0.055;

fp=fopen("tau2.dat","w");
for theta0=1*pi/180:1*pi/180:176*pi/180
    i=1;
    n=floor((116-16)/10)+1;
    q_vec=zeros(n,1);
    c_t_vec=zeros(n,1);
    for r=16e-9:10e-9:116e-9
        syms f(theta)
        f=dE_theta(theta0,sigma,theta,r,g,rho,l);
        thetamin=vpasolve(f,theta,[0.0001*pi/180 179.9*pi/180]);
        q_vec(i)=1/r;
        c_t_vec(i)=double(cos(thetamin)-cos(theta0));
        i=i+1;
    end
    V=1e-15;
    syms f2(theta)
    f2=dE_theta_V(theta0,sigma,theta,V,g,rho,l);
    theta_app=vpasolve(f2,theta,[0*pi/180 179.99*pi/180]);
    
    tbl=table(q_vec,c_t_vec,'VariableNames',{'q','c_t'});
    mdl=fitlm(tbl,'c_t~q');
    m=mdl.Coefficients.Estimate(2);
    tau=-sigma*m;
    
    fprintf(fp,"%f %.30f\n",theta_app,tau);

end

fclose(fp);


function dE_theta_val=dE_theta(theta0,sigma,theta,r2,g,rho,l)
t1 = sigma * pi;
t2 = r2 ^ 2;
t3 = t2 * r2;
t4 = sin(theta);
t5 = t4 ^ 2;
t7 = 0.1e1 / t5 / t4;
t9 = (t3 * t7) ^ (0.1e1 / 0.3e1);
t10 = 0.1e1 / t9;
t11 = cos(theta);
t12 = 0.1e1 - t11;
t14 = 0.1e1 / t5;
t15 = t3 * t14;
t19 = 0.2e1 + t11;
t23 = -0.2e1 / 0.3e1 * t15 / t12 + t15 / t19 / 0.3e1;
t27 = t9 ^ 2;
t28 = t27 * t4;
t31 = l * sigma;
t32 = 0.1e1 / t27;
t38 = cos(theta0);
t43 = (sigma * t38 - 0.2e1 * t31 * t10) * pi;
t51 = rho * g;
t52 = pi * t3;
t55 = t12 ^ 2;
t56 = t55 * t12;
t57 = t56 * t19;
t59 = 0.3e1 + t11;
t61 = 0.8e1 + 0.4e1 * t11;
t62 = 0.1e1 / t61;
t69 = t51 * t52 * t14;
t71 = t9 * t59;
t83 = t61 ^ 2;
dE_theta_val = 0.4e1 * t1 * t10 * t12 * t23 + 0.2e1 * t1 * t28 - 0.2e1 * t31 * t32 * t23 * pi * t5 - 0.2e1 * t43 * t10 * t5 * t23 - 0.2e1 * t43 * t28 * t11 + t51 * t52 * t7 * t57 * t32 * t59 * t62 * t23 / 0.3e1 + t69 * t55 * t19 * t71 * t62 / 0.3e1 - t51 * t52 * t14 * t56 * t19 * t9 * t62 / 0.3e1 + 0.4e1 / 0.3e1 * t69 * t57 * t71 / t83;
end

function dE_theta_V_val=dE_theta_V(theta0,sigma,theta,V,g,rho,l)
t1 = cos(theta);
t3 = (-0.1e1 + t1) ^ 2;
t4 = 0.1e1 / t3;
t6 = 0.2e1 + t1;
t9 = (0.1e1 / t6 * t4 * V) ^ (0.1e1 / 0.3e1);
t10 = t9 ^ 2;
t13 = pi ^ (0.1e1 / 0.3e1);
t15 = 3 ^ (0.1e1 / 0.3e1);
t18 = t13 ^ 2;
t21 = cos(theta0);
t27 = t1 ^ 2;
t30 = l * sigma;
t45 = sin(theta);
t47 = t6 ^ 2;
dE_theta_V_val = t4 / t47 / t6 * t45 * (-0.2e1 * t9 * (t1 - t21) * t6 * t15 * sigma * t18 + 0.2e1 * t30 * t27 * t1 * pi + 0.8e1 * t30 * t27 * pi + 0.6e1 * t30 * t1 * pi + rho * g * V - 0.4e1 * pi * l * sigma) * t15 / t13 * V / t10;
end
