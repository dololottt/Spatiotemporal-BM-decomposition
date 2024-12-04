# Tensor Bhattacharya-Mesner (BM) decomposition

This project is based on the paper:

"Tensor BM-Decomposition for Compression and Analysis of Video Data" (available: https://arxiv.org/abs/2306.09201)

Given a tensor 𝓧 of size $$m\times p \times n$$, its BM-rank $$\ell$$ decomposition can be written as a sum of $$\ell$$ BM-rank 1 terms. Each BM-rank 1 term is a BM-outer product of the tensors 𝓐, 𝓑, 𝓒 with size $$m\times 1 \times n$$, $$m \times p \times 1$$, and $$1 \times p \times n$$, respectively. See the following figure illustration.

<img width="578" alt="Screenshot 2024-12-04 at 4 24 26 PM" src="https://github.com/user-attachments/assets/2c16b701-796d-46b9-95d9-dc8f25291680">
