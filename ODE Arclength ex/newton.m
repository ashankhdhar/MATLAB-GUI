clear all;
Uint=zeros(1,1);
U  = 0.3;

lambda = 0.1;
h=0.001;
n=0;
nmax=10;

ds=0.1;
time = 100;
arclength = 1:1:time;
norm_v = zeros(1,time);
lambda_v = zeros(1,time);
eig_val = zeros(1,time);

tic;
while n < nmax
    J=u_jacobian(U,lambda);
    
    F=eval_u(U,lambda);
    
    du=-J\(F);
    U=U+du;
    n=n+1;
end

udot = U/ds;
ldot = lambda/ds;

u_0=0;
l_0=0;

for i = 1:length(arclength)
    lambdaint = l_0+ds*ldot;
    uint = u_0 + ds*udot;
    err=1;
     while abs(err)>1e-9
        JF(1,1)=u_jacobian(uint,lambdaint);
        JF(1,2) = lam_jacobian(uint);
        JF(2,1) = udot;
        JF(2,2) = ldot;
        
        all_u(1) = eval_u(uint,lambdaint);
        all_u(2) = (uint-u_0)'*udot+(lambdaint-l_0)*ldot - ds;
        
        duF=-JF\(all_u');
        uint=uint+duF(1); uint;
        lambdaint = lambdaint +duF(2);
        err = eval_u(uint,lambdaint);
     end
     
    normu = sum(uint)*h;
    norm_v(i) = normu;
    lambda_v(i) = lambdaint;
    
    new_f = [zeros(1); 1];
    udot_1 = JF\new_f;
    
    udot = udot_1(1);
    ldot = udot_1(2);
    
    u_0= uint;
    l_0 = lambdaint; 
 
end

figure()
plot(lambda_v,norm_v,'o')
ylim([-6e-3 6e-3])
xlim([-6 8])
xlabel('\lambda')
ylabel('u(x)')
title('Graph of u(x) with respect to \lambda')

