% Alternating Least Squares
clear;

load escalator_data %

X = double(X);
% initialization number of frames
nFrames = size(X,2);
% function
mat  = @(x)reshape(x, m, n );
% Fold video frames into a hypermatrix
A = zeros(m,n,nFrames);
for k=1:nFrames
    A(:,:,k) = mat(X(:,k));
end

%clear X;
%V2 = double(V2);
%A=A(51:120, 51:120, 1:70); % cubic slice
A = A(:,:,1:100);

% no transpose
%X = A;

% transpose of input video
X = permute(A, [2,3,1]); 

% transpose twice of input video
%X = permute(A, [3,1,2]); 

T = X; %/fronorm(X);
% max rank targeted
max_rank = 2;
% check max_rank < min(size(Tvid))
% error('MyComponent:incorrectType',...
%'Error. \nmax_rank must be less than the minimum dimension of input tensor)

% max # of iterations
max_iter = 0;
% target tolerence 
tol = 0.001;
% Initial guess by slice-SVD
sthreshold = 0.0005;
[U, V, sliceS] = sliceSVD(T, max_rank, sthreshold);
S = BMP_mid_solver(T, U, V);

% nuclear norm of every slice
Tnnorm = sum(sliceS); %(1:max_rank,:)
max(Tnnorm)

% loop
iter = 0;
err = 1e3;
errList=[];
while (err > tol) && (iter < max_iter)
    % Initialization of output hypermatrix-the middle S
    Tt=permute(T, [2,3,1]); St=permute(S,[2,3,1]); Ut=permute(U,[2,3,1]);
    Vt = BMP_mid_solver(Tt, St, Ut);
    V = permute(Vt, [3,1,2]); %HMtrp(HMtrp(Vt));
    Ttt = permute(T, [3,1,2]); Vtt=permute(V, [3,1,2]); Stt=permute(S, [3,1,2]);
    Utt = BMP_mid_solver(Ttt, Vtt, Stt);
    U = permute(Utt,[2,3,1]);
    S = BMP_mid_solver(T, U, V);
    % compute relative error in frobenius norm
    That = BMP(U,S,V);
    % check SVD-rank of first slice
    sigma1 = svd(That(:,:, 50));
    %disp(['approximate rank=',  median(num2str(sigma1), 'all')]);
    %figure; 
    %plot(sigma1); xlim([0 10])
    err = fronorm(T-That)/fronorm(T);
    errList = [errList, err];
    iter = iter+1;
    disp(['Iter=', num2str(iter), '; error=', sprintf('%03d',err)]);
end  

% plot error over iteration
figure; 
semilogy(errList);

figure; 
semilogy(sliceS); xlim([1, 15])
% Compare with S is all one, and use only matrix SVD
%S2 = ones(size(S)); %S; %

T1 = BMP(U(:,1,:), S(:,:,1), V(1,:,:)); %no transpose
%T1 = permute(T1,[3,1,2]); %transpose once
T1 = permute(T1,[2,3,1]); %transpose twice

T2 = BMP(U(:,2,:), S(:,:,2), V(2,:,:)); %no transpose
%T2 = permute(T2,[3,1,2]); %transpose once
T2 = permute(T2,[2,3,1]); %transpose twice

%T3 = BMP(U(:,3,:), S(:,:,3), V(3,:,:)); %no transpose
%T3 = permute(T3,[3,1,2]); %transpose once
%T3 = permute(T3,[2,3,1]); %transpose twice


That2 = T2; %+T3;
That = BMP(U, S, V);
% That = permute(That, [3,1,2]); %transpose once
That = permute(That, [2,3,1]); %transpose twice

% check image
f1=24; f2=10; dp=0;
%f2=1; f3=1;
figure; 
colormap( 'Gray' );
% Tensor T1
subplot(2,4,1); imagesc(T1(:,:,dp+f1)); title(sprintf('Frame %i of T1 tensor', dp+f1), 'FontSize', 14); 
subplot(2,4,5); imagesc(T1(:,:,dp+f2)); title(sprintf('Frame %i of T1 tensor', dp+f2), 'FontSize', 14); 
% Tensor T2
subplot(2,4,2); imagesc(That2(:,:,dp+f1)); title(sprintf('Frame %i of T2+T3 tensor', dp+f1), 'FontSize', 14); 
subplot(2,4,6); imagesc(That2(:,:,dp+f2)); title(sprintf('Frame %i of T2+T3 tensor', dp+f2), 'FontSize', 14); 
% Approx
subplot(2,4,3); imagesc(That(:,:,f1)); title(sprintf('Frame %i of appx: T1+T2+T3', dp+f1), 'FontSize', 14);
subplot(2,4,7); imagesc(That(:,:,f2)); title(sprintf('Frame %i of appx: T1+T2+T3', dp+f2), 'FontSize', 14);
% Original
subplot(2,4,4); imagesc(A(:,:,f1)); title(sprintf('Frame %i of original tensor', dp+f1), 'FontSize', 14);
subplot(2,4,8); imagesc(A(:,:,f2)); title(sprintf('Frame %i of original tensor', dp+f2), 'FontSize', 14);


% Analysis of slice-wise singular vectors
Shat1 = zeros(size(T));
Shat2 = zeros(size(T));
%Shat3 = zeros(size(T));
for k=1:size(T,3)
    Shat1(:,:,k) = U(:,1,k)*V(1,:,k);
    Shat2(:,:,k) = U(:,2,k)*V(2,:,k);
    %Shat3(:,:,k) = U(:,3,k)*V(3,:,k);
end
%transpose once
%Shat1 = permute(Shat1, [3,1,2]); 
%Shat2 = permute(Shat2, [3,1,2]); 
%Shat3 = permute(Shat3, [3,1,2]); 

%transpose twice
Shat1 = permute(Shat1, [2,3,1]); 
Shat2 = permute(Shat2, [2,3,1]); 
%Shat3 = permute(Shat3, [3,1,2]); 

% singular vector outer products
Shat = Shat2; %+Shat3;

% plot singular vector images
figure; 
colormap( 'Gray' );
% Tensor T1
subplot(2,4,1); imagesc(Shat1(:,:,dp+f1)); title(sprintf('Frame %i of U1*V1^t tensor', dp+f1), 'FontSize', 14); 
subplot(2,4,5); imagesc(Shat1(:,:,dp+f2)); title(sprintf('Frame %i of U1*V1^t tensor', dp+f2), 'FontSize', 14); 
% Tensor T2
subplot(2,4,2); imagesc(Shat(:,:,dp+f1)); title(sprintf('Frame %i of U2*V2^t+U3*V3^t tensor', dp+f1), 'FontSize', 14); 
subplot(2,4,6); imagesc(Shat(:,:,dp+f2)); title(sprintf('Frame %i of U2*V2^t+U3*V3^t tensor', dp+f2), 'FontSize', 14); 

