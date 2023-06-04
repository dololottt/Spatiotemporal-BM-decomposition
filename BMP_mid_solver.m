function B = BMP_mid_solver(T, A, C)
    % This function implements the least-squares middle tensor solver for 
    % general ALS method.
    
    % sizes of the input
    [m,n,p] = size(T); ell = size(A,2);
    % Intialize an empty hypermatrix B
    B = zeros(m, n, ell);
    % Fill depth fibers of the hypermatrix B
    %H = zeros(m*n*p, m*n*ell); Hb = zeros(m*n*p,1);
    for i = 1:m
        for j = 1:n
            % Fill the container matrix H by product of entries of U and V
            %H = zeros(p, ell);
            for k = 1:p
                for t = 1:ell
                    H(k,t) = A(i,t,k)*C(t,j,k);
                    %H((i-1)*n*p+(j-1)*p+k, (i-1)*n*ell+(j-1)*ell+t) = A(i,t,k)*C(t,j,k);
                    %Hb((i-1)*n*p+(j-1)*p+k) = T(i,j,k);
                end
            end
            % Obtain depth fiber of the input T
            Hb = squeeze(T(i,j,:));
            % Solve system of linear equations to obtain depth fiber of B
            B(i,j,:)= lsqminnorm(H, Hb); %H\Hb; %  %nnls(H,Hb); 
            %disp(['condition number of (', num2str([i,j]), ') = ', num2str(cond(H))])
        end
    end
    %x = H\Hb; %save('saveH.mat','H');
    %x11 = reshape(x, ell, n, []); B = permute(x11, [3,2,1]);
end