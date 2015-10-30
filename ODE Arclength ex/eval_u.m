function uprime = eval_u(U,lambda)
uprime=zeros(2,1);
uprime = (lambda-(U.*(U-1).*(U-2))-2);