% Regular network structure connectivity matrix

% Moore Nearest neighbor - patch connected with 8 nearest patches
% (vertical - horizontal - diagonal)

function [ConnectivityMatrix] = RegularGraph(n,CONNECTED,graph,Torus);
%# grid size

%# 4-/8- connected points



%# which distance function
if CONNECTED == 4,     distFunc = 'cityblock';  %4 nearest neighbors
elseif CONNECTED == 8, distFunc = 'chebychev'; end %8 nearest neighbors



%# compute adjacency matrix
[X Y] = meshgrid(1:n,1:n);
X = X(:); Y = Y(:);
ConMatrix = squareform( pdist([X Y], distFunc) == 1 );

%if plot = 1 - allow plotting, if = 2 do not allow plotting
if graph==0
    disp('no plot')
end
if graph == 1
    [X Y] = meshgrid(1:n,1:n);
    X = X(:); Y = Y(:);
    %# plot adjacency matrix
    subplot(121), spy(ConMatrix)
    %# plot connected points on grid
    [xx yy] = gplot(ConMatrix, [X Y]);
    subplot(122), plot(xx, yy, 'ks-', 'MarkerFaceColor','r')
    axis([0 n+1 0 n+1])
    %# add labels
    [X Y] = meshgrid(1:n,1:n);
    X = reshape(X',[],1) + 0.1; Y = reshape(Y',[],1) + 0.1;
    text(X, Y(end:-1:1), cellstr(num2str((1:n*n)')) )
end



if Torus==0
    disp('no torus')
end
%Torus with 4 nearest neighbour connections
if Torus==1 & CONNECTED ==4
    
    z=n;
    % First Row connected with last row
    for i=1:n:n*n
        ConMatrix(i,z)=1;%up
        ConMatrix(z,i)=1; %up
        z=z+n;
    end
    
    %First Column connected with last column
    for i=1:n
        ConMatrix(i,n*n-n+i)=1;
        ConMatrix(n*n-n+i,i)=1;
    end
    
end

%Torus with 8 nearest neighbour connections
if Torus==1 & CONNECTED ==8
    
    
    % First row connected with last row
    z=n;
    for i=1:n:n*n
        ConMatrix(i,z)=1;
        ConMatrix(z,i)=1;
        z=z+n;
    end
    
    %First column connected with last column
    for i=1:n
        ConMatrix(i,n*n-n+i)=1;
        ConMatrix(n*n-n+i,i)=1;
    end
    
    %CORNERS
    
    %First Corner - position "1"
    
    ConMatrix(1,n*n)=1;
    ConMatrix(n*n,1)=1;
    ConMatrix(1,2*n)=1;
    ConMatrix(2*n,1)=1;
    ConMatrix(1,n*n-n+2)=1;
    ConMatrix(n*n-n+2,1)=1;
    
    %Second Corner - position "n"
    
    ConMatrix(n,n*n-n+1)=1;
    ConMatrix(n*n-n+1,n)=1;
    ConMatrix(n,n*n-1)=1;
    ConMatrix(n*n-1,n)=1;
    ConMatrix(n,n+1)=1;
    ConMatrix(n+1,n)=1;
    
    %Third Corner - position "n*n-n+1"
    
    
    ConMatrix(n*n-n,n*n-n+1)=1;
    ConMatrix(n*n-n+1,n*n-n)=1;
    ConMatrix(n*n-n+1,2)=1;
    ConMatrix(2,n*n-n+1)=1;
    
    %Fourth Corner - position "n*n"
    
    
    ConMatrix(n*n-2*n+1,n*n)=1;
    ConMatrix(n*n,n*n-2*n+1)=1;
    ConMatrix(n*n,n-1)=1;
    ConMatrix(n-1,n*n)=1;
    
    
    % First row connected with last row diagonally
    z=3*n;
    for i=n+1:n:(n*n-2*n)
        ConMatrix(i,z)=1;
        ConMatrix(z,i)=1;
        z=z+n;
    end
    
    z=2*n;
    for i=2*n+1:n:(n*n-n)
        ConMatrix(i,z)=1;
        ConMatrix(z,i)=1;
        z=z+n;
    end
    
    %First column connected with last column diagonally
    for i=2:(n-2)
        ConMatrix(i,n*n-n+i+1)=1;
        ConMatrix(n*n-n+i+1,i)=1;
    end
    
    for i=3:(n-1)
        ConMatrix(i,n*n-n+i-1)=1;
        ConMatrix(n*n-n+i-1,i)=1;
    end
    
    
end
