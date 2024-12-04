function [U, V, sliceS, Tsvd, Tbg, Tfg, SVDerr] = sliceSVD(T, ell)
% This function takes the input hypermatrix and performs SVD on frontal 
% slices of T. Slices U and V are consequently folded back along the third 
% dimension to hypermatrices. Then the function solves for S from BMP(U,S,V)=T.
% 
% Input: 
% T: thrid order hypermatrix; 
% ell: BM rank truncation parameter;
% sthreshold: threshold of singular values in matrix SVD.
%
% Output:
% U: left singular vector hyperamtrix - from slice matrix SVD. Each frontal
% slice is orthogonal
% V: right singular vector hypermatrix - from slice matrix SVD. Each
% frontal slice is orthogonal
% sliceS: matrix SVD singular values - used to refine sthreshold
T = double(T);
% Obtain size parameter of the input T
[m,n,p]=size(T);
% Create hypermatrix U: frontal slices are the left-singular matrices
U=zeros(m,ell,p); 
% Create hypermatrix V: frontal slices are the right-singular matrices
V=zeros(ell,n,p); 
% Create hypermatrix Tsvd: slice-wise SVD approximation
Tsvd=zeros(m,n,p); 
% Create slice-SVD BG/FG
%Tbg=zeros(m,n,p); 
%Tfg=zeros(m,n,p); 
% Record singular values of each slice
q=min(m,n);
sliceS=zeros(q,p);
% Record SVD f-norm
SVDerr=zeros(p,1);
% Take matrix SVD with frontal slices of the smaller cube hypermatrix T
for i = 1:p
    %disp([num2str(i), ' rank:', num2str(rank(T(:,:,i)))])
    [Mu,Ms,Mv]=svd(T(:,:,i), 'econ'); % Use SVD
    sliceS(:,i)= diag(Ms);
    % slice-wise low-rank svd approximation
    Msvd = Mu(:,1:ell)*Ms(1:ell,1:ell)*Mv(:,1:ell)';
    Tsvd(:,:,i) = Msvd;
    % approximation error
    SVDerr(i,1) = fronorm(T(:,:,i) - Msvd);
    % Append U slices by the left-singular vector*singular value
    U(:,:,i) = Mu(:,1:ell)*Ms(1:ell,1:ell);
    % Append V slicesV by the right-singular vectors
    V(:,:,i) = Mv(:,1:ell)'; 

    % slice-wise svd bg/fg
    Msvd_bg = Mu(:,1)*Ms(1,1)*Mv(:,1)'; %Tsvd_bg(:,:,i) = Msvd_bg;
    Msvd_fg = Mu(:,2:ell)*Ms(2:ell,2:ell)*Mv(:,2:ell)'; %Tsvd_fg(:,:,i) = Msvd_fg;

end
% % Slice-svd video bg/fg
Z = ones([m,n,ell]);
% index for background slice
a=1; 
% separate bg/fg by slice SVD
Tbg = BMP(U(:,1:a,:), Z(:,:,1:a), V(1:a,:,:)); 
Tfg = BMP(U(:,(a+1):ell,:), Z(:,:,(a+1):ell), V((a+1):ell,:,:));
end