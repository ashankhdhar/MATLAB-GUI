clear all;
clc;

N=50;
nk=N^2;%time run
dt = .1;
h=pi/N;
x = linspace(0,pi,N);
y = linspace(0,pi,N);
u = zeros(N,N,3);
% a(:,:) = zeros(N); % initial value of a, b and c
% 
% 
% b(:,:)= zeros(N);
% 
% c(:,:) =zeros(N);

%%THESE ARE THE INITIAL CONDITION CALLS
%THE SPIRAL CAN BE EDIT IN THIS ONE:
%InitSpiralGridPDE(latticesize, number of spirals, radius of circle,
%seedsize)
%UNCOMMENT LINE BELOW TO RUN:
[a,b,c]= InitSpiralGridPDE(N,3,5,2); %3 spirals, 10 radius, 1 seed width

%The Anti spiral will only work with number of spiral =1; Makes initial
%conditions in paper labeled (c) cannot figure out how to make (e)
%[a,b,c]=InitAntiSpiralGridPDE4(N,1,5,1);% a(:,:)=InitSpirialGridPDE(N,2, 10,1)[1];
% b(:,:)=InitSpirialGridPDE(N,2, 10,1)[2];
% c(:,:)=InitSpirialGridPDE(N,2, 10,1)[3];


% a(:,:) = 1/3*rand(N,N); % initial value of a, b and c
% 
% 
% b(:,:)= 1/3*rand(N,N);
% 
% c(:,:) =1/3*rand(N,N);
% a(5,25)=1;
% a(40,10)=1;
% a(40,40)=1;
% c(10,10)=1;
% c(30,40)=1;
% b(45,30)=1;
% b(10,40)=1;
% b(30,10)=1;
% c(45,20)=1;


%two are spiral
% a(5,25)=1;
% a(45,25)=1;
% b(10,10)=1;
% b(40,40)=1;
% c(20,40)=1;
% c(30,10)=1;

%Two arm Anti spiral
% a(15,15)=1;
% b(7,7)=1;
% b(7,22)=1;
% c(22,7)=1;
% c(22,22)=1;


% %four corners right
% c(12,32)=1;
% a(12,44)=1;
% c(38,32) = 1;
% %c(38,38)=1;
% a(38,44)=1;
% %center left
% a(25,12)=1;
% %center right
% c(25,38)=1;
% %four corners left
% b(12,6)=1;
% b(12,18)=1;
% 
% b(38,6)=1;
% 
% b(38,18)=1;

Dm=.0005;
%Dm=1;
q=10;
p=2.3;%p will control the spiralocity of this system 
r=dt/h^2;

a_old=zeros(N,1);
index=1;
for i=1:(N)
    for j=1:(N)
        a_old(index)=a(i,j);
        index=1+index;
    end
end

b_old=zeros(N,1);
index=1;
for i=1:(N)
    for j=1:(N)
        b_old(index)=b(i,j);
        index=1+index;
    end
end

c_old=zeros(N,1);
index=1;
for i=1:(N)
    for j=1:(N)
        c_old(index)=c(i,j);
        index=1+index;
    end
end


C=zeros((N)^2);%initialize the big block tridiag

for j=1:(N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            C(j,k)=2+3*Dm*r;%diagonal of diagonal block
            
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            C(j,k)=2+2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
            
        end
    end
end

for j=(N+1):(N^2-N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            C(j,k)=2+4*Dm*r;%diagonal of diagonal block
            
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            C(j,k)=2+3*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
            
        end
    end
end

for j=(N^2-N+1):(N^2)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            C(j,k)=2+3*Dm*r;%diagonal of diagonal block
            
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            C(j,k)=2+2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
            
        end
    end
end

B=zeros((N)^2);%initialize the big block tridiag

for j=1:(N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            B(j,k)=2-3*Dm*r;%diagonal of diagonal block
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            B(j,k)=2-2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other clocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        end
    end
end

for j=(N+1):(N^2-N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            B(j,k)=2-4*Dm*r;%diagonal of diagonal block
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            B(j,k)=2-3*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other clocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        end
    end
end


for j=(N^2-N+1):(N^2)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            B(j,k)=2-3*Dm*r;%diagonal of diagonal block
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            B(j,k)=2-2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other clocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        end
    end
end

%%
count=0;
% hold on;
for l=1:1000
     
     rho=1-a_old-b_old-c_old;
     
  for i=1:N^2
        a_forcing(i,1)=q*rho(i)*a_old(i)-p*a_old(i)*c_old(i);
        b_forcing(i,1)=q*rho(i)*b_old(i)-p*b_old(i)*a_old(i);
        c_forcing(i,1)=q*rho(i)*c_old(i)-p*c_old(i)*b_old(i);
  end
   
    a_new=sparse(C)\(sparse(B)*sparse(a_old)+sparse(dt)*sparse(a_forcing));%crank nicolson
    b_new=sparse(C)\(sparse(B)*sparse(b_old)+sparse(dt)*sparse(b_forcing));
    c_new=sparse(C)\(sparse(B)*sparse(c_old)+sparse(dt)*sparse(c_forcing));
    index=1;
    for k=1:length(a_new)
        if(a_new(k)>1)
            a_new(k)=1;
        end
    end
    for k=1:length(b_new)
        if(b_new(k)>1)
            b_new(k)=1;
        end
    end
    for k=1:length(c_new)
        if(c_new(k)>1)
            c_new(k)=1;
        end
    end
    
    for i=1:(N)
        for j=1:(N)   
            u(i,j,1)=a_new(index);
            u(i,j,2)=b_new(index);
            u(i,j,3)=c_new(index);
            index=index+1;
          
        end
    end
    if mod(l,5)==0; %p is the interation time
       
        if(max(max(max(u)))>1)
            disp('greater than 1');
            count=count+1;
        else
            image(u);%plot
            saveas(gcf,num2str(l),'png');
            drawnow;
            colorbar;
        end
       % pause(.1);
    end 
%     sum(sum(sum(u)))
    a_old=a_new;
    b_old=b_new;
    c_old=c_new;
end
count

