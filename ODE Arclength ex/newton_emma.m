clear all;
hold on;

%% Set up the environment for the plot

title('Graph of u(x) with respect to \lambda')
xlabel('\lambda')
ylabel('u(x)')
xlim([0 4])
ylim([-1 3])
p1=scatter([],[],5,'filled','b');
p2=scatter([],[],5,'filled','r');
legend([p1 p2],'Stable','Unstable','Location','northwest')

%% Initialize 

Uint=zeros(1,1);
U  = Uint;
lambda = 0;
ds=0.1; % in system use 1/100
time = 100;
norm_v = zeros(1,time);
lambda_v = zeros(1,time);
err=1;

%% Run Newtons to find 2 initial solution

tic;
% Find the first fixed point
while abs(err)>1e-9
    J=u_jacobian(U,lambda);
    
    F=eval_u(U,lambda);
    
    du=-J\(F);
    U=U+du;
    err=eval_u(U,lambda);
end

% Find the second fixed point
lambda2=lambda+0.001;
U2=U;
while abs(err)>1e-9
    J=u_jacobian(U2,lambda2);
    
    F=eval_u(U2,lambda2);
    
    du=-J\(F);
    U2=U2+du;
    err=eval_u(U2,lambda2);
end

% Approximate u dot and recale to make sure we start...
% in the right direction
dot_vec=[(U2-U),(lambda2-lambda)];
dot_vec=dot_vec/norm(dot_vec);

udot=dot_vec(1);
ldot=dot_vec(2);

%% Pseudo-Arclength Continuation Method

lambda=lambda2;
u_0=0;
l_0=0;
new_f = [zeros(1); 1];
for i = 1:time
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
        err=eval_u(uint,lambdaint);
    end
    
    normu = sum(uint);
    norm_v(i) = normu;
    lambda_v(i) = lambdaint;
    
    udot_1 = JF\new_f;
    udot_1=udot_1/norm(udot_1);
    udot = udot_1(1);
    ldot = udot_1(2);
    u_0= uint;
    l_0 = lambdaint;
    
    eig_val= real(eig(JF(1:1,1:1)));
    % Stable f.p
    if (eig_val<0)
        p1=scatter(lambda_v(i),norm_v(i),5,'filled','b');
        drawnow
    % Unstable f.p
    else
        p2=scatter(lambda_v(i),norm_v(i),5,'filled','r');
        drawnow
    end
    hold on
end



