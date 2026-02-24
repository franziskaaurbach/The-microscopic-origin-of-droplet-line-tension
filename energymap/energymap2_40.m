clear;

sigma=0.055;
V=1e-18;
l=5e-9;
beta=1;
chi=beta*sigma/l;
f=0.1;

theta_deg=40;
theta0=(theta_deg)*pi/180;

fp=fopen(append("data_",num2str(theta_deg),".dat"),"w");
fp_minmax=fopen(append("data_minmax_",num2str(theta_deg),".dat"),"w");

E_min=10000;
E_max=-10000;
theta_min=10000;
theta_max=-10000;

step_size=0.001;
M=zeros(1/step_size+1,1/step_size+1);

p=cos(theta0)*(-sigma/(l*chi))
0.5*(1-p)

for phi_L=0:step_size:1
    phi_L
    for phi_G=0:step_size:1
        fhandle = @(th) dE(sigma, V, phi_L, phi_G, theta0, l, chi, th);

        
        ths  = linspace(0, pi, 200);
        vals = arrayfun(fhandle, ths);

        idx  = find(vals(1:end-1).*vals(2:end) < 0);

        thetamin = fzero(fhandle, [ths(idx), ths(idx+1)]);

        E1=E(sigma,V,phi_L,phi_G,theta0,l,chi,f,thetamin)/(sigma*(3*V*sqrt(pi))^(2/3));
        M(round(phi_L/step_size+1),round(phi_G/step_size+1))=E1;
        thetamin_deg=thetamin*180/pi;
        if mod(phi_L/step_size,10)==0 && mod(phi_G/step_size,10)==0
            fprintf(fp,"%f %f %.20f %f\n",phi_L,phi_G,E1,thetamin_deg);
        end
        if E_min>E1
            E_min=E1;
        end
        if E_max<E1
            E_max=E1;
        end
        if theta_min>thetamin_deg
            theta_min=thetamin_deg;
        end
        if theta_max<thetamin_deg
            theta_max=thetamin_deg;
        end
        if phi_L==0 && theta_deg==150 && phi_G>0.99
            plot(phi_G,E1,'.')
            hold on
        end
    end
    if mod(phi_L/step_size,10)==0
        fprintf(fp,"\n");
    end
end

fprintf(fp_minmax,"%.20f\n",E_min);
fprintf(fp_minmax,"%.20f\n",E_max);
fprintf(fp_minmax,"%.20f\n",theta_min);
fprintf(fp_minmax,"%.20f\n",theta_max);

fclose(fp);
fclose(fp_minmax);

fp2=fopen(append("data_min_",num2str(theta_deg),".dat"),"w");

number_min=0;
for phi_L=0:step_size:1
    for phi_G=0:step_size:1
        i_loc=round(phi_L/step_size+1.0);
        j_loc=round(phi_G/step_size+1.0);
        phi_G_loc=phi_G;
        phi_L_loc=phi_L;
        %middle
        if (phi_G~=0 && (phi_L~=0 && (phi_G~=1 && phi_L~=1)))
            if (M(i_loc,j_loc)<M(i_loc,j_loc+1) && M(i_loc,j_loc)<M(i_loc,j_loc-1) && M(i_loc,j_loc)<M(i_loc+1,j_loc) && M(i_loc,j_loc)<M(i_loc-1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no j+1
        elseif (phi_G_loc==1 && phi_L_loc~=0 && phi_L_loc~=1)
            if (M(i_loc,j_loc)<M(i_loc,j_loc-1) && M(i_loc,j_loc)<M(i_loc+1,j_loc) && M(i_loc,j_loc)<M(i_loc-1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no j-1
        elseif (phi_G_loc==0 && phi_L_loc~=0 && phi_L_loc~=1)
            if (M(i_loc,j_loc)<M(i_loc,j_loc+1) && M(i_loc,j_loc)<M(i_loc+1,j_loc) && M(i_loc,j_loc)<M(i_loc-1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no i+1
        elseif (phi_L_loc==1 && phi_G_loc~=0 && phi_G_loc~=1)
            if  (M(i_loc,j_loc)<M(i_loc,j_loc+1) && M(i_loc,j_loc)<M(i_loc,j_loc-1)  && M(i_loc,j_loc)<M(i_loc-1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no i-1
        elseif (phi_L_loc==0 && phi_G_loc~=0 && phi_G_loc~=1)
            if ( M(i_loc,j_loc)<M(i_loc,j_loc+1) && M(i_loc,j_loc)<M(i_loc,j_loc-1) && M(i_loc,j_loc)<M(i_loc+1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no j+1 and i+1
        elseif (phi_L_loc==1 && phi_G_loc==1)
            if ( M(i_loc,j_loc)<M(i_loc,j_loc-1) && M(i_loc,j_loc)<M(i_loc-1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no j-1 and i+1
        elseif (phi_L_loc==1 && phi_G_loc==0)
            if ( M(i_loc,j_loc)<M(i_loc,j_loc+1) &&  M(i_loc,j_loc)<M(i_loc-1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no j+1 and i-1
        elseif (phi_L_loc==0 && phi_G_loc==1)
            if ( M(i_loc,j_loc)<M(i_loc,j_loc-1) && M(i_loc,j_loc)<M(i_loc+1,j_loc))
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        % no j-1 and i-1
        elseif (phi_L_loc==0 && phi_G_loc==0)
            if (M(i_loc,j_loc)<M(i_loc,j_loc+1)  && M(i_loc,j_loc)<M(i_loc+1,j_loc) )
                fprintf(fp2,"%f %f %f\n", phi_L_loc,phi_G_loc,M(i_loc,j_loc));
                number_min=number_min+1;
            end
        end
    end
end
number_min
fclose(fp2);
S = fileread(append("data_min_",num2str(theta_deg),".dat"));
S = [mat2str(number_min) newline S];
FID = fopen(append("data_min_",num2str(theta_deg),".dat"), 'w');
if FID == -1
    error('Cannot open file %s', FileName); 
end
fwrite(FID, S, 'char');
fclose(FID);



function E_val=E(sigma,V,phi_L,phi_G,theta0,l,chi,f,theta)
cg=phi_G;
cg1=phi_L;
t2 = 3 ^ (0.1e1 / 0.3e1);
t3 = t2 ^ 2;
t5 = V / pi;
t6 = cos(theta);
t7 = 0.1e1 - t6;
t8 = t7 ^ 2;
t14 = (t5 / t8 / (0.2e1 + t6)) ^ (0.1e1 / 0.3e1);
t15 = t14 ^ 2;
t16 = t3 * t15;
t20 = l * chi;
t21 = cg ^ 2;
t22 = cos(theta0);
t28 = 0.1e1 + t22 * sigma / l / chi;
t30 = t28 * cg - t21;
t32 = cg1 ^ 2;
t45 = sin(theta);
t46 = t45 ^ 2;
t52 = (0.1e1 - t22) ^ 2;
t58 = (t5 / t52 / (0.2e1 + t22)) ^ (0.1e1 / 0.3e1);
t59 = t58 ^ 2;
t61 = sin(theta0);
t62 = t61 ^ 2;
E_val = 0.2e1 * sigma * pi * t16 * t7 - (t20 * t30 - t20 * (t28 * cg1 - t32) + 0.2e1 / 0.3e1 * l * (cg - cg1) * sigma * t3 / t14) * pi * t16 * t46 + t20 * t30 * pi * t3 * t59 * t62 * (1 + f);
end

function dE_theta_val=dE(sigma,V,phi_L,phi_G,theta0,l,chi,theta)
cg=phi_G;
cg1=phi_L;
t1 = cos(theta);
t2 = 0.2e1 + t1;
t6 = (-0.1e1 + t1) ^ 2;
t7 = 0.1e1 / t6;
t9 = (V / t2 * t7) ^ (0.1e1 / 0.3e1);
t10 = t9 ^ 2;
t12 = 3 ^ (0.1e1 / 0.3e1);
t14 = cg - cg1;
t15 = cos(theta0);
t24 = pi ^ (0.1e1 / 0.3e1);
t25 = t24 ^ 2;
t29 = t1 ^ 2;
t40 = sin(theta);
t42 = t2 ^ 2;
dE_theta_val = -0.2e1 / t10 * (t12 * (t1 * sigma - t14 * (t15 * sigma - (l * chi * (cg + cg1 - 1)))) * t25 * t9 + l * pi * sigma * (t29 + 0.2e1 * t1 - 0.1e1) * t14) / t24 * V * t12 * t40 * t7 / t42;
end