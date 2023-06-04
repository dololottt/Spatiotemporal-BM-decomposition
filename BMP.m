function T = BMP(A,B,C)

%A = rand(m,ell,p); B = rand(m,n,ell); C = rand(ell,n,p);

[m,ell,p]=size(A); 

[M,n,L]=size(B);

[LL,N,P]=size(C);

if m~=M || L~= ell || LL~=ell || N ~=n || P~=p
    disp('wrong size')
    return
end

%i=1:m; j=1:n, k=1:p
% T is m x n x p

Im = speye(m);
for j=1:n
    for k=1:p
        tmp = A(:,:,k)';  a = tmp(:); 
        tmp2 = squeeze(B(:,j,:))'; b = tmp2(:);
        v = a.*b;  %Hadamard product
        T(:,j,k) = kron(Im,squeeze(C(:,j,k))')*v;
    end
end
