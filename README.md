# Tensor BM-decomposition

This project is based on our paper:

"Tensor BM-Decomposition for Compression and Analysis of Video Data" (available: https://arxiv.org/abs/2306.09201)

Given tensors $$\mathcal{A}$$, $$\mathcal{B}$$, $$\mathcal{C}$$ of size $$m\times 1 \times n$$, $$m \times p \times 1$$, and $$1 \times p \times n$$, respectively, their Bhattacharya-Mesner (BM) product will result in a third-order tensor of dimension $$m \times p \times n$$ and BM-rank of 1 (Mesner and Bhattacharya, 1990). Thus, if an arbitrary $$m \times p \times n$$ third-order tensor can be written as a sum of a small number, relative to $$m,p,n$$, of such BM-rank 1 terms, this BM-decomposition (BMD) offers an implicitly compressed representation of the tensor. 


<img width="578" alt="Screenshot 2024-12-04 at 4 24 26 PM" src="https://github.com/user-attachments/assets/2c16b701-796d-46b9-95d9-dc8f25291680">
