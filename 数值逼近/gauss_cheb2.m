function v = gauss_cheb2 (f, n)
    x = cos(((0:n)'+1)*pi/(n+2));
    w = pi./(n+2).*(sin(((0:n)'+1)*pi/(n+2))).^2;
    v = f(x)'*w;