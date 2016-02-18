clc 
clear 
close all

phi_x1x2 = [0.1,0.7;0.8,0.3];
phi_x2x3 = [0.5,0.1;0.1,0.5];
phi_x3x4 = [0.1,0.5;0.5,0.1];
phi_x4x5 = [0.9,0.3;0.1,0.3];

n=5;
psis = cell(n-1,1);
separator = cell(n-2,1);

for i=1:n-2
separator{i} = [1,1];
end

%initialize psis randomly
% for i = 1:(n-1)
% psis{i} = rand(2,2);
% end

%initialize psis using given function
psis{1} = phi_x1x2;
psis{2} = phi_x2x3;
psis{3} = phi_x3x4;
psis{4} = phi_x4x5;


for t = 1:n-2
    temp_s = separator{t} ;
    separator{t} = sum( psis{t},1 );
    psis{t+1} =repmat( (separator{t} ./temp_s)',1,2) .* psis{t+1};
end 

for k = n-2:-1:1
    temp_s = separator{k} ;
    separator{k} = sum( psis{k+1}' );
    psis{k} = repmat(separator{k} ./temp_s,2,1) .* psis{k};
end

for i=1:n-2
    separator{i} = separator{i}./sum(separator{i});
end

for i=1:n-1
    psis{i} = psis{i} ./ sum(sum(psis{i})) ;
end

