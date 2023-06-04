function [U, S, V, errList, ediffList, That] = bmp_als(X, U0, S0, V0, tol, maxit)
    % This function implements the Alternating Least Squares function on
    % : 3D intial guess tensors
    % Inputs: 
    % T - 3D tensor: normalized
    % trank -  target rank-ell
    % orientation - default is X, optional: X.transpose, X.transpose_twice
    % tol - tolerence of relative error
    % maxit - maximum number of iterations
    % ----------------------------
    U = U0;
    S = S0;
    V = V0;
   
    % -------- ALS iteration ---------
    % loop
    iter = 0;
    That = BMP(U,S,V);
    err = fronorm(X-That)/fronorm(X);
    %disp(['Iter=', num2str(iter), '; error=', sprintf('%03d',err)]);
    errList=[err];
    ediffList=[];
    Tlist = [];
    while (err > tol) && (iter < maxit)
        % old approximate
        X_old = That; 
        % Transpose once-solve for V given U & S.
        Tt=permute(X, [2,3,1]); St=permute(S,[2,3,1]); Ut=permute(U,[2,3,1]);
        Vt = BMP_mid_solver(Tt, St, Ut);
        V = permute(Vt, [3,1,2]);
        % Transpose twice-solve for U given V & S.
        Ttt = permute(X, [3,1,2]); Vtt=permute(V, [3,1,2]); Stt=permute(S, [3,1,2]);
        Utt = BMP_mid_solver(Ttt, Vtt, Stt);
        U = permute(Utt,[2,3,1]);
        % Solve for S given U & V.
        S = BMP_mid_solver(X, U, V);
        % compute relative error to input in frobenius norm
        That = BMP(U,S,V);
        err_rel = fronorm(X-That)/fronorm(X);
        % add new error to list 
        errList = [errList, err_rel];
        % compute error as relative change in approximation 
        err_diff = fronorm(That-X_old)/fronorm(X_old);
        ediffList = [ediffList, err_diff];
        % use consecutive_error
        err = err_rel; %err_diff;
        % use relative error
        %err = err_rel;
        % update to next iteration
        iter = iter+1;
        %disp(['Iter=', num2str(iter), '; consecutive error = ', sprintf('%03d', err)]);
        %if mod(iter, 30) == 0
        disp(['Iter=', num2str(iter), '; relative error = ', sprintf('%03d', err_diff)]);
        %end
    end  
end