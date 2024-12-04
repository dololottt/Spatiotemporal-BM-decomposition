function B = BMP_mid_solver(T, A, C)
    % This function implements the least-squares middle tensor solver for 
    % general ALS method.
    T = double(T);
    % sizes of the input
    [m,n,p] = size(T); ell = size(A,2);
    % Intialize an empty hypermatrix B
    B = zeros(m, n, ell);
    % Fill depth fibers of the hypermatrix B
    count = 0;
    for i = 1:m
        for j = 1:n
            % Fill the container matrix H by product of entries of U and V
            %H = zeros(p, ell);
            for k = 1:p
                for t = 1:ell
                    H(k,t) = A(i,t,k)*C(t,j,k);
                end
            end
            % Obtain depth fiber of the input T
            Vy = squeeze(T(i,j,:));
            % Solve system of linear equations to obtain depth fiber of B
            count = count + 1;
            %saveHmat{count} = H;
            %saverhs(:, count) = Vy;
            B(i,j,:)= lsqminnorm(H, Vy); %  %nnls(H, Vy); H\Vy; %
            %disp(['condition number of (', num2str([i,j]), ') = ', num2str(cond(H))])
        end
    end
    %BB = matlab.internal.math.blkdiag(saveHmat{:}); 
    %brhs = saverhs(:);
    %Vb = BB\brhs; 
    %x11 = reshape(Vb, ell, n, []); B = permute(x11, [3,2,1]);
end