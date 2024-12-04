# Tensor Bhattacharya-Mesner (BM) decomposition

This project is based on the paper:

"Tensor BM-Decomposition for Compression and Analysis of Video Data" (available: https://arxiv.org/abs/2306.09201)

Given a tensor 𝓧 of size $$m\times p \times n$$, its BM-rank $$\ell$$ decomposition can be written as a sum of $$\ell$$ BM-rank 1 terms. Each BM-rank 1 term is a BM-outer product of the tensors 𝓐, 𝓑, 𝓒 with size $$m\times 1 \times n$$, $$m \times p \times 1$$, and $$1 \times p \times n$$, respectively. See the following figure illustration.

<img width="578" alt="Screenshot 2024-12-04 at 4 24 26 PM" src="https://github.com/user-attachments/assets/2c16b701-796d-46b9-95d9-dc8f25291680">

### Dataset
- Datasets "Simulated Video" (grayscale and color), "Car" (grayscale), and "Escalator" (grayscale) are available in the folder "data".

- Datasets "Hall and Monitor", "Human Body", and "IBM Test" can be accessed at the "Scene Background Initialization (SBI) dataset" website: 
https://sbmi2015.na.icar.cnr.it/SBIdataset.html 

### BMD of video data
Run 'demo_tensor_bmd' file. 

We will obtain the tensor BM-rank 5 decomposition results of the car video.

<img src="https://github.com/user-attachments/assets/e75f36ab-ca9f-4bd0-9e74-927961e0a241" width=50% height=50%>

Comparison of the BMD reconstructed frames with the slice-wise SVD reconstructed frame (\# 60).

<img src="https://github.com/user-attachments/assets/9725db47-0a8b-4334-8361-ba446e64679c" width=40% height=40%>

Comparison of the BMD reconstructed background/foreground frames with the SS-SVD reconstructed reconstructed background/foreground frames.
