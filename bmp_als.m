function [A, B, C, errList, ediffList, Xhat] = bmp_als(T, A0, B0, C0, tol, maxit)
    % This function implements the Alternating Least Squares to find BMD
    % Input:
    % T: ground-truth data tensor
    % A0, B0, C0: initial guess tensor triplet
    % tol: tolerance parameter for error
    % maxit: maximum number of iterations
    % Output:
    % A, B, C: BMD factor tensor triplet
    % errList: relative error to ground-truth T
    % ediffList: relative error of consecutive iterations
    % Xhat: approximated tensor to T
    % Author: Fan Tian
    % --------------------------------------------------------
    
    % Initialize set of factor tensors
    A = A0; B = B0; C = C0;
    % Initial approximation
    Xhat = BMP(A, B, C);
    % Compute initial relative error
    rel_err = fronorm(T-Xhat)/fronorm(T); 
    err = rel_err;
    % Initialize empty list to store error
    errList=[rel_err]; %relative error
    ediffList=[]; %relative difference error
    % Specify transposes
    t = [2,3,1];
    tt = [3,1,2];
    % -------- ALS iteration ---------
    % Begin loop
    iter = 1;
    disp(['Iter=', num2str(iter), '; relative error to gt=', num2str(err)]);
    while (err > tol) && (iter < maxit)
        % old approximate
        X_old = Xhat; 
        
        % -- Transpose data twice: Holding C,B fixed and solve for A --
        Ttt = permute(T, tt); 
        % permute C and B factors
        Ctt = permute(C, tt); Btt = permute(B, tt);
        % solve for Att
        Att = BMP_mid_solver(Ttt, Ctt, Btt);
        % permute back A
        A = permute(Att, t);
        
        % -- No Transpose: Holding A,C fixed and solve for B --
        B = BMP_mid_solver(T, A, C);
        
        % -- Transpose data once: Holding B,A fixed and solve for C --
        Tt = permute(T, t);
        % permute B and A factors
        Bt = permute(B, t); At = permute(A, t);
        % solve for Ct
        Ct = BMP_mid_solver(Tt, Bt, At);
        % permute back C
        C = permute(Ct, tt);
        % ------------------------------
        % Compute BMP with updated factor tensors
        Xhat = BMP(A, B, C);
        % compute new relative error
        rel_err = fronorm(T - Xhat)/fronorm(T);
        % add new error to list 
        errList = [errList, rel_err];
        % compute error as relative change in approximation 
        err_diff = fronorm(Xhat-X_old)/fronorm(X_old);
        ediffList = [ediffList, err_diff];
        % use consecutive_error
        err = err_diff; 
        % update to next iteration
        iter = iter+1;
        if mod(iter, 30) == 0
            disp(['itr=', num2str(iter), '; consecutive relative error = ', num2str(err), ...
                '; relative error to gt = ', num2str(rel_err)]);
        end
    end  
end