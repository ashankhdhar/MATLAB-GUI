clear all;
%Yint=zeros(3,1);
Yint = [0.8;1;0.6];
Y = Yint;

param = 0.001;

ds=0.04;
time = 1000;

norm_y = zeros(1,time);
param_y = zeros(1,time);
err=1;
tic;

while abs(err)>1e-9
    J=jacob(Y,param);
    
    F=eval_y(Y,param);
    
    du=-J\(F);
    Y=Y+du;
    err=eval_y(Y,param);
end

ydot = Y/ds;
pdot = param/ds;

y_0=0;
p_0=0;
new_f = [zeros(3,1); 1];

for i = 1:time
    paramint = p_0+ds*pdot;
    yint = y_0 + ds*ydot;
    err=1;
     while abs(err)>1e-9
        JF=jacob(yint,paramint);
        JF(1:3,4) = param_jacob(yint);
        JF(4,1:3) = ydot;
        JF(4,4) = pdot;
        
        all_y = eval_y(yint,paramint);
        all_y(4) = (yint-y_0)'*ydot+(paramint-p_0)*pdot - ds;
        
        duF=-JF\(all_y);
        yint=yint+duF(1:3); yint;
        paramint = paramint +duF(4);
        err=eval_y(yint,paramint);
        
     end
     
    normy = sum(yint);
    norm_y(i) = normy;
    param_y(i) = paramint;
   
    ydot_1 = JF\new_f;
    ydot_1=ydot_1/norm(ydot_1);
    udot = ydot_1(1:3);
    ldot = ydot_1(4);  
    y_0= yint;
    p_0 = paramint; 

end

figure()
scatter(param_y,norm_y,5,'filled')
xlabel('\mu')
ylabel('y(x)')
title('Graph of u(x) with respect to \mu')