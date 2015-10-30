function J = u_jacobian(U,lambda)
J=zeros(1,1);
J(1,1) = -3.*(U.^2)+(6.*U)-2;