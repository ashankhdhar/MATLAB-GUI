function[species_a,species_b, species_c ] = InitSpiralGridPDE(Width,NumSpiral,radius,SeedSize) 

angle=2*pi/(NumSpiral*3);
species_a=zeros(Width,Width);
species_b=zeros(Width,Width);
species_c=zeros(Width,Width);
seed=floor(SeedSize/2);

% for i=1:Width 
%     for j=1:Width 
%         species_a(i,j)=0;
%         species_b(i,j)=0;
%         species_c(i,j)=0;
%     end 
% end
% 
% for i=1:Width
%     Lattice(i,Width)=5; 
%     Lattice(Width,i)=5; 
%     Lattice(1,i)=5; 
%     Lattice(i,1)=5;
% end

for i=0:NumSpiral-1
    x1=floor(Width/2+radius*cos(angle*3*i)); 
    y1=floor(Width/2+radius*sin(angle*3*i)); 
    x2=floor(Width/2+radius*cos(angle*(3*i+1)));
    y2=floor(Width/2+radius*sin(angle*(3*i+1))); 
    x3=floor(Width/2+radius*cos(angle*(3*i+2))); 
    y3=floor(Width/2+radius*sin(angle*(3*i+2)));
    
    for k=-seed:seed
        for m=-seed:seed
            species_a(x1+k,y1+m)=1;
            species_b(x2+k,y2+m)=1;
            species_c(x3+k,y3+m)=1;
        end
    end
    
end