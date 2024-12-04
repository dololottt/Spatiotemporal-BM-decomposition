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
Run 'demo_tensor_bmd' file. We will obtain the tensor BM-rank 5 decomposition results of the car video.

![img1](https://github.com/user-attachments/assets/5001faec-eef7-4c77-8087-fb460b96c133)
Comparison of the BMD reconstructed frames with the slice-wise SVD reconstructed frame (\# 60).


![img2](https://github.com/user-attachments/assets/e356f069-3455-42be-b56a-43362dd6c7f4)
Comparison of the BMD reconstructed background/foreground frames with the SS-SVD reconstructed reconstructed background/foreground frames.
