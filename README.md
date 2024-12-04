# Tensor BM-decomposition

This project is based on our paper:
``Tensor BM-Decomposition for Compression and Analysis of Video Data'' available: https://arxiv.org/abs/2306.09201 

Given tensors $$\mathcal{A}$$, $$\mathcal{B}$$, $$\mathcal{C}$$ of size $$m\times 1 \times n$$, $$m \times p \times 1$$, and $$1 \times p \times n$$, respectively, their Bhattacharya-Mesner (BM) product will result in a third-order tensor of dimension $$m \times p \times n$$ and BM-rank of 1 (Mesner and Bhattacharya, 1990). Thus, if an arbitrary m×p×n third-order tensor can be written as a sum of a small number, relative to $$m,p,n$$, of such BM-rank 1 terms, this BM-decomposition (BMD) offers an implicitly compressed representation of the tensor. In this paper, we first show that grayscale surveillance video can be accurately captured by a low BM-rank decomposition and give methods for efficiently computing this decomposition. To this end, we first give results that connect rank-revealing matrix factorizations to the BMD. Next, we present a generative model that illustrates that spatio-temporal video data can be expected to have low BM-rank. We combine these observations to derive a regularized alternating least squares (ALS) algorithm to compute an approximate BMD of the video tensor. The algorithm itself is highly parallelizable since the bulk of the computations break down into relatively small regularized least squares problems that can be solved independently. Extensive numerical results compared against the state-of-the-art matrix-based DMD for surveillance video separation show our algorithms can consistently produce results with superior compression properties while simultaneously providing better separation of stationary and non-stationary features in the data. We then introduce a new type of BM-product suitable for color video and provide an algorithm that shows an impressive ability to extract important temporal information from color video while simultaneously compressing the data.
