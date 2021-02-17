function [S,Niter] = Muldin(x)
%This function realizes MULDIN algorithm for the input integer vector "x"

SZ = size(x);  
if SZ(2)>SZ(1)
    x = x'; %Now we just make sure that it is a column vector
end
N = max(SZ); %This is the number of the space dimensions

%=========================================================================================
i1=(2*(x>=0)-1); % i1 is Nx1 column which has 1 for non-negative x and -1 for negative x
i1 = repmat(i1,1,N); %We replicate this column N times
S = eye(N).*i1;  %This will create the matrix S0, which is made of unitary matrix but every diagonal element is replaced by i1 (which is either +1 or -1)

%Now we will make sure that the determinant of this matrix is still
%positive
if (det(S)<0)
    S(:,[1,2]) = S(:,[2,1]); %Otherwise swap the first and the second column to make sure that the coordinate system is right-handed
end
%=========================================================================================
X = S^(-1)*x; %Get the coordinates of the vector "x" after the initialization. All the elements of "X" will be non-negative 
NonZeros=find(X); %See which components are nonzeros
m1 = max(NonZeros);  %Find the maximum index of the non-zero element: we will make sure that it will be N
PermuteArray = [1:N,1:N];
if (m1<N)
    %The last coordinate of the vector "X" is zero 
    a1 = m1 + 1;
    a2 = m1 + N;
    S = S(:,PermuteArray(a1:a2));
    X = S^(-1)*x;
end
stop=(numel(NonZeros)<=1); %In case if only one is non-zero then quit
I = eye(N);
Niter = 0;
while (stop==0)
%We know that at this point all the coordinates Xp are not negative    
    NonZeros = find(X); %Find which ones are zeros
    Mn = min(X(NonZeros)); %Let us find the smallest of those that is not zero
    m1 = find((X == Mn),1,'last'); %It might happen that there are many of them and we choose the latest to ensure that AN is involved. 
    T = I;  %We start with the unitary matrix
    T(:,m1) = 0; %
    T(NonZeros,m1) = 1; %And assign "1" to all the rows which correspond to nonzero coordinates   
    S=S*T;
    X = T^(-1)*X; %And get the coordinates of the vector in this coorinate system which must be NONNEGATIVE
    NonZeros=find(X>0); %See which components are nonzeros
    stop=(numel(NonZeros)==1); %In case if only one is non-zero then quite;
    Niter = Niter + 1;
end

