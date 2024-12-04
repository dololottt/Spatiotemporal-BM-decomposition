% Demo: Video tensor BM-decomposition
% By - Fan Tian
% Date - 12/04/2024
% 
% Reference: "Tensor BM-Decomposition for Compression and Analysis of Video Data"
% Paper available: https://arxiv.org/abs/2306.09201
%

% Import data
vid = double(importdata('data/gray_carvid.mat'));

% Permute tensor: frames as lateral slices
T = permute(vid, [1,3,2]);

% Initialize dimensions of data
[m, p, n] = size(T);

% Set BM-rank ell
ell = 5;

% Use slice-wise SVD for initial guesses
[A0, C0] = sliceSVD(T, ell);

% Initialize B0 as all ones
B0 = ones(m, p, ell);

% Slice-wise SVD approximated tensor
Tsvd = BMP(A0, B0, C0);

% BMD-ALS algorithm parameters
tol = 1e-5;
maxItr = 150;

% Compute BM-rank ell decomposition
[A, B, C] = bmp_als(T, A0, B0, C0, tol, maxItr);
Tbmd = BMP(A, B, C);

% Permute results as frontal clies
Tsvd = permute(Tsvd, [1,3,2]);
Tbmd = permute(Tbmd, [1,3,2]);

% Background and foreground separation
% -- SS-SVD background subtraction --
Tsvd_bg = BMP(A0(:,1,:), B0(:,:,1), C0(1,:,:)); 
Tsvd_fg = T - Tsvd_bg; 

Tsvd_bg = permute(Tsvd_bg, [1,3,2]);
Tsvd_fg = permute(Tsvd_fg, [1,3,2]);

% -- BMD: background (BM-rank 1) --
% -- BMD: foreground (BM-rank 3) --
Tbmd_bg = BMP(A(:,1,:), B(:,:,1), C(1,:,:)); Tbmd_bg = permute(Tbmd_bg, [1,3,2]);
Tbmd_fg = BMP(A(:,2:ell,:), B(:,:,2:ell), C(2:ell,:,:)); Tbmd_fg = permute(Tbmd_fg, [1,3,2]); 

% Visualize reconstruction results
fm = 60;
figure; colormap('gray');
subplot(1,3,1); imshow(covt(vid(:,:,fm))); title(sprintf('Original frame %d', fm))
subplot(1,3,2); imshow(covt(Tsvd(:,:,fm))); title('SS-SVD reconstructed video')
subplot(1,3,3); imshow(covt(Tbmd(:,:,fm))); title('BMD reconstructed video')

figure; colormap('gray');
subplot(2,2,1); imshow(covt(Tsvd_bg(:,:,fm))); title('SS-SVD reconstructed background')
subplot(2,2,2); imshow(covt(Tsvd_fg(:,:,fm))); title('SS-SVD reconstructed foreground')
subplot(2,2,3); imshow(covt(Tbmd_bg(:,:,fm))); title('BMD reconstructed background')
subplot(2,2,4); imshow(covt(Tbmd_fg(:,:,fm))); title('BMD reconstructed foreground')




