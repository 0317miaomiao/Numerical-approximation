function I = gauss_L(f,n)
   beta = .5./sqrt(1 - (2*(1:n)).^(-2));
   T = diag(beta, 1) + diag(beta, -1);
   [V, D] = eig(T);
   x = diag(D);
   w = 2*V(1,:).^2;
   I = w*f(x);
end
